# Copyright (c) 2007-2008 The PyAMF Project.
# See LICENSE for details.

"""
RemoteObject Tests.

@author: U{Nick Joyce<mailto:nick@boxdesign.co.uk>}
@since: 0.1
"""

import unittest

import pyamf
from pyamf import remoting
from pyamf.remoting import amf3, gateway
from pyamf.flex import messaging

class RandomIdGeneratorTestCase(unittest.TestCase):
    def test_generate(self):
        x = []

        for i in range(5):
            id_ = amf3.generate_random_id()

            self.assertTrue(id_ not in x)
            x.append(id_)

class AcknowlegdementGeneratorTestCase(unittest.TestCase):
    def test_generate(self):
        ack = amf3.generate_acknowledgement()

        self.assertTrue(isinstance(ack, messaging.AcknowledgeMessage))
        self.assertTrue(ack.messageId is not None)
        self.assertTrue(ack.clientId is not None)
        self.assertTrue(ack.timestamp is not None)

    def test_request(self):
        ack = amf3.generate_acknowledgement(pyamf.ASObject(messageId='123123'))

        self.assertTrue(isinstance(ack, messaging.AcknowledgeMessage))
        self.assertTrue(ack.messageId is not None)
        self.assertTrue(ack.clientId is not None)
        self.assertTrue(ack.timestamp is not None)

        self.assertEquals(ack.correlationId, '123123')

class RequestProcessorTestCase(unittest.TestCase):
    def test_create(self):
        rp = amf3.RequestProcessor('xyz')
        self.assertEquals(rp.gateway, 'xyz')

    def test_ping(self):
        message = messaging.CommandMessage(operation=5)
        rp = amf3.RequestProcessor(None)
        request = remoting.Request('null', body=[message])

        response = rp(request)
        ack = response.body

        self.assertTrue(isinstance(response, remoting.Response))
        self.assertEquals(response.status, remoting.STATUS_OK)
        self.assertTrue(isinstance(ack, messaging.AcknowledgeMessage))
        self.assertEquals(ack.body, True)

    def test_request(self):
        def echo(x):
            return x

        gw = gateway.BaseGateway({'echo': echo})
        rp = amf3.RequestProcessor(gw)
        message = messaging.RemotingMessage(body=['spam.eggs'], operation='echo')
        request = remoting.Request('null', body=[message])

        response = rp(request)
        ack = response.body

        self.assertTrue(isinstance(response, remoting.Response))
        self.assertEquals(response.status, remoting.STATUS_OK)
        self.assertTrue(isinstance(ack, messaging.AcknowledgeMessage))
        self.assertEquals(ack.body, 'spam.eggs')

    def test_error(self):
        def echo(x):
            raise TypeError

        gw = gateway.BaseGateway({'echo': echo})
        rp = amf3.RequestProcessor(gw)
        message = messaging.RemotingMessage(body=['spam.eggs'], operation='echo')
        request = remoting.Request('null', body=[message])

        response = rp(request)
        ack = response.body

        self.assertTrue(isinstance(response, remoting.Response))
        self.assertEquals(response.status, remoting.STATUS_ERROR)
        self.assertTrue(isinstance(ack, messaging.ErrorMessage))
        self.assertEquals(ack.faultCode, 'TypeError')

    def test_too_many_args(self):
        def spam(bar):
            return bar

        gw = gateway.BaseGateway({'spam': spam})
        rp = amf3.RequestProcessor(gw)
        message = messaging.RemotingMessage(body=['eggs', 'baz'], operation='spam')
        request = remoting.Request('null', body=[message])

        response = rp(request)
        ack = response.body

        self.assertTrue(isinstance(response, remoting.Response))
        self.assertEquals(response.status, remoting.STATUS_ERROR)
        self.assertTrue(isinstance(ack, messaging.ErrorMessage))
        self.assertEquals(ack.faultCode, 'TypeError')

    def test_preprocess(self):
        def echo(x):
            return x

        self.called = False

        def preproc(sr, *args):
            self.called = True

            self.assertEquals(args, ('spam.eggs',))
            self.assertTrue(isinstance(sr, gateway.ServiceRequest))

        gw = gateway.BaseGateway({'echo': echo}, preprocessor=preproc)
        rp = amf3.RequestProcessor(gw)
        message = messaging.RemotingMessage(body=['spam.eggs'], operation='echo')
        request = remoting.Request('null', body=[message])

        response = rp(request)
        ack = response.body

        self.assertTrue(isinstance(response, remoting.Response))
        self.assertEquals(response.status, remoting.STATUS_OK)
        self.assertTrue(isinstance(ack, messaging.AcknowledgeMessage))
        self.assertEquals(ack.body, 'spam.eggs')
        self.assertTrue(self.called)

    def test_fail_preprocess(self):
        def preproc(sr, *args):
            raise IndexError

        def echo(x):
            return x

        gw = gateway.BaseGateway({'echo': echo}, preprocessor=preproc)
        rp = amf3.RequestProcessor(gw)
        message = messaging.RemotingMessage(body=['spam.eggs'], operation='echo')
        request = remoting.Request('null', body=[message])

        response = rp(request)
        ack = response.body

        self.assertTrue(isinstance(response, remoting.Response))
        self.assertEquals(response.status, remoting.STATUS_ERROR)
        self.assertTrue(isinstance(ack, messaging.ErrorMessage))

    def test_destination(self):
        def echo(x):
            return x

        gw = gateway.BaseGateway({'spam.eggs': echo})
        rp = amf3.RequestProcessor(gw)
        message = messaging.RemotingMessage(body=[None], destination='spam', operation='eggs')
        request = remoting.Request('null', body=[message])

        response = rp(request)
        ack = response.body

        self.assertTrue(isinstance(response, remoting.Response))
        self.assertEquals(response.status, remoting.STATUS_OK)
        self.assertTrue(isinstance(ack, messaging.AcknowledgeMessage))
        self.assertEquals(ack.body, None)


def suite():
    suite = unittest.TestSuite()

    suite.addTest(unittest.makeSuite(RandomIdGeneratorTestCase))
    suite.addTest(unittest.makeSuite(AcknowlegdementGeneratorTestCase))
    suite.addTest(unittest.makeSuite(RequestProcessorTestCase))

    return suite

if __name__ == '__main__':
    unittest.main(defaultTest='suite')
