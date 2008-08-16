# Copyright (c) 2007-2008 The PyAMF Project.
# See LICENSE for details.

"""
AMF3 RemoteObject support.

@see: U{RemoteObject on LiveDocs
<http://livedocs.adobe.com/flex/3/langref/mx/rpc/remoting/RemoteObject.html>}

@since: 0.1.0
"""

import calendar, time, uuid, sys

import pyamf
from pyamf import remoting
from pyamf.flex import messaging

error_alias = pyamf.get_class_alias(messaging.ErrorMessage)

class BaseServerError(pyamf.BaseError):
    """
    Base server errror
    """

class ServerCallFailed(BaseServerError):
    """
    A catchall error.
    """
    _amf_code = 'Server.Call.Failed'

pyamf.register_class(ServerCallFailed, attrs=error_alias.attrs)

del error_alias

def generate_random_id():
    return str(uuid.uuid4())

def generate_acknowledgement(request=None):
    ack = messaging.AcknowledgeMessage()

    ack.messageId = generate_random_id()
    ack.clientId = generate_random_id()
    ack.timestamp = calendar.timegm(time.gmtime())

    if request:
        ack.correlationId = request.messageId

    return ack

def generate_error(request, cls, e, tb):
    """
    Builds an L{ErrorMessage<pyamf.flex.messaging.ErrorMessage>} based on the
    last traceback and the request that was sent.
    """
    import traceback

    if hasattr(cls, '_amf_code'):
        code = cls._amf_code
    else:
        code = cls.__name__

    detail = []

    for x in traceback.format_exception(cls, e, tb):
        detail.append(x.replace("\\n", ''))

    return messaging.ErrorMessage(messageId=generate_random_id(),
        clientId=generate_random_id(), timestamp=calendar.timegm(time.gmtime()),
        correlationId = request.messageId, faultCode=code, faultString=str(e),
        faultDetail=str(detail), extendedData=detail)

class RequestProcessor(object):
    def __init__(self, gateway):
        self.gateway = gateway

    def buildErrorResponse(self, request, error=None):
        """
        Builds an error response.

        @param request: The AMF request
        @type request: L{Request<pyamf.remoting.Request>}
        @return: The AMF response
        @rtype: L{Response<pyamf.remoting.Response>}
        """
        if error is not None:
            cls, e, tb = error
        else:
            cls, e, tb = sys.exc_info()

        return generate_error(request, cls, e, tb)

    def _getBody(self, amf_request, ro_request, **kwargs):
        """
        @raise ServerCallFailed: Unknown request.
        """
        if isinstance(ro_request, messaging.CommandMessage):
            return self._processCommandMessage(amf_request, ro_request, **kwargs)
        elif isinstance(ro_request, messaging.RemotingMessage):
            return self._processRemotingMessage(amf_request, ro_request, **kwargs)
        elif isinstance(ro_request, messaging.AsyncMessage):
            return self._processAsyncMessage(amf_request, ro_request, **kwargs)
        else:
            raise ServerCallFailed, "Unknown request: %s" % ro_request

    def _processCommandMessage(self, amf_request, ro_request, **kwargs):
        """
        @raise ServerCallFailed: Unknown Command operation.
        """
        ro_response = generate_acknowledgement(ro_request)

        if ro_request.operation == messaging.CommandMessage.PING_OPERATION:
            ro_response.body = True

            return remoting.Response(ro_response)
        elif ro_request.operation == messaging.CommandMessage.LOGIN_OPERATION:
            raise ServerCallFailed, "Authorization is not supported in RemoteObject"
        elif ro_request.operation == messaging.CommandMessage.DISCONNECT_OPERATION:
            return remoting.Response(ro_response)
        else:
            raise ServerCallFailed, "Unknown Command operation %s" % ro_request.operation

    def _processAsyncMessage(self, amf_request, ro_request, **kwargs):
        ro_response = generate_acknowledgement(ro_request)
        ro_response.body = True

        return remoting.Response(ro_response)

    def _processRemotingMessage(self, amf_request, ro_request, **kwargs):
        ro_response = generate_acknowledgement(ro_request)

        service_name = ro_request.operation

        if hasattr(ro_request, 'destination') and ro_request.destination:
            service_name = '%s.%s' % (ro_request.destination, service_name)

        service_request = self.gateway.getServiceRequest(amf_request,
                                                         service_name)

        # fire the preprocessor (if there is one)
        self.gateway.preprocessRequest(service_request, *ro_request.body,
                                       **kwargs)

        ro_response.body = self.gateway.callServiceRequest(service_request,
                                                *ro_request.body, **kwargs)

        return remoting.Response(ro_response)

    def __call__(self, amf_request, **kwargs):
        """
        Processes an AMF3 Remote Object request.

        @param amf_request: The request to be processed.
        @type amf_request: L{Request<pyamf.remoting.Request>}

        @return: The response to the request.
        @rtype: L{Response<pyamf.remoting.Response>}
        """
        ro_request = amf_request.body[0]

        try:
            return self._getBody(amf_request, ro_request, **kwargs)
        except (KeyboardInterrupt, SystemExit):
            raise
        except:
            return remoting.Response(self.buildErrorResponse(ro_request),
                                     status=remoting.STATUS_ERROR)
