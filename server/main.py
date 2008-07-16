import wsgiref.handlers
from pyamf.remoting.gateway.wsgi import WSGIGateway
from services import EchoService, ProjectService

services = {
    'EchoService': EchoService.EchoService,
    'ProjectService': ProjectService.ProjectService,
}

def main():
    application = WSGIGateway(services)
    wsgiref.handlers.CGIHandler().run(application)

if __name__ == '__main__':
    main()
