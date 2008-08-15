import wsgiref.handlers
from pyamf.remoting.gateway.wsgi import WSGIGateway
from services import EchoService, ProjectsService, ProjectParticipantsService

services = {
    'EchoService': EchoService.EchoService,
    'ProjectsService': ProjectsService.ProjectsService,
    'ProjectParticipantsService': ProjectParticipantsService.ProjectParticipantsService,
}

def main():
    application = WSGIGateway(services)
    wsgiref.handlers.CGIHandler().run(application)

if __name__ == '__main__':
    main()
