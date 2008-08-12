"""Flex and Python Test client

Usage:

client.py test
    Echo test.
client.py insert 1 "Project name"
    Inserts a new project with code = 1 and name = "Project name".
client.py get 1
    Gets a project with code = 1.
client.py update 1 "New project name"
    Updates the name on the project with code = 1.
client.py delete 1 3 7
    Deletes the projects with codes = 1, 3 and 7.
client.py initialize
    Deletes all current data and inserts sample projects and participants.
client.py all
    Lists all projects.
client.py participants
    Lists all project participants.
"""

from pprint import pprint
import sys
from pyamf.remoting.client import RemotingService

def usage():
    print __doc__

def test():
    gateway = RemotingService('http://localhost:8080/')
    project_service = gateway.getService('EchoService')
    print project_service.echo('test')
    print project_service.echo_upper('test')
    print project_service.echo_upper(1)

def insert(code, name):
    gateway = RemotingService('http://localhost:8080/')
    project_service = gateway.getService('ProjectsService')
    new_project = {
        "code": int(code),
        "name": name,
        "department": 0,
    }
    project = project_service.save(new_project)
    print_project(project)

def update(code, name):
    gateway = RemotingService('http://localhost:8080/')
    project_service = gateway.getService('ProjectsService')
    project = project_service.get_by_code(int(code))
    project.name = name
    project = project_service.save(project)
    print_project(project)

def get(code):
    gateway = RemotingService('http://localhost:8080/')
    project_service = gateway.getService('ProjectsService')
    project = project_service.get_by_code(int(code))
    if project == None:
        print "Project %s not found." % (code)
    else:
        print_project(project)

def delete(codes):
    gateway = RemotingService('http://localhost:8080/')
    project_service = gateway.getService('ProjectsService')
    for code in codes:
        project = project_service.get_by_code(int(code))
        if project != None:
            project_service.delete(project)

def initialize():
    # prepare service objects
    gateway = RemotingService('http://localhost:8080/')
    project_service = gateway.getService('ProjectsService')
    project_participants_service = gateway.getService('ProjectParticipantsService')

    # delete all participants
    participants = project_participants_service.get_all()
    for participant in participants:
        project_participants_service.delete(participant)

    # delete all projects
    projects = project_service.get_all()
    for project in projects:
        project_service.delete(project)

    # insert projects
    sample_projects = [ {"code": 104, "name": "Foobar 2008", "department": 1,},
                        {"code": 201, "name": "Server consolidation", "department": 3,},
                        {"code": 207, "name": "Flex training", "department": 2,},
                        {"code": 321, "name": "Desktop purchase", "department": 5,} ]
    for project in sample_projects:
        project_service.save(project)

    # insert participants
    project_104_key = project_service.get_by_code(104)._key
    project_201_key = project_service.get_by_code(201)._key
    project_207_key = project_service.get_by_code(207)._key
    project_321_key = project_service.get_by_code(321)._key
    sample_participants = [ {"project_key": project_104_key, "name": "Breanna Gallasin",},
                            {"project_key": project_104_key, "name": "Fyra Ginn",},
                            {"project_key": project_104_key, "name": "Jakuu Retwin",},
                            {"project_key": project_104_key, "name": "Jeran Corse",},
                            {"project_key": project_201_key, "name": "Kavindra Sudime",},
                            {"project_key": project_201_key, "name": "Ken Gundo",},
                            {"project_key": project_201_key, "name": "Kitrep Starr",},
                            {"project_key": project_201_key, "name": "Murgh Ashen",},
                            {"project_key": project_201_key, "name": "Meeraval Soto",},
                            {"project_key": project_207_key, "name": "Milka Praxon",},
                            {"project_key": project_207_key, "name": "Fyra Ginn",},
                            {"project_key": project_207_key, "name": "Zarli Orden",},
                            {"project_key": project_321_key, "name": "Rundo Quamar",},
                            {"project_key": project_321_key, "name": "Kavindra Sudime",},
                            {"project_key": project_321_key, "name": "Uldir Greeta",},
                            {"project_key": project_321_key, "name": "Vash Cari",},
                            {"project_key": project_321_key, "name": "Breanna Gallasin",},
                            {"project_key": project_321_key, "name": "Fyra Ginn",},
                            {"project_key": project_321_key, "name": "Jeran Corse",} ]
    for participant in sample_participants:
        project_participants_service.save(participant)

def all():
    gateway = RemotingService('http://localhost:8080/')
    project_service = gateway.getService('ProjectsService')
    projects = project_service.get_all()
    for project in projects:
        print_project(project)

def participants():        
    gateway = RemotingService('http://localhost:8080/')
    project_participants_service = gateway.getService('ProjectParticipantsService')
    participants = project_participants_service.get_all()
    for participant in participants:
        pprint(participant)
        
def print_project(project):
    pprint(project)

def main(args):
    if len(args) == 0:
        usage()
        return 1
    command = args[0]
    if command == 'test' and len(args) == 1:
        test()
    elif command == 'insert' and len(args) == 3:
        insert(args[1], args[2])
    elif command == 'get' and len(args) == 2:
        get(args[1])
    elif command == 'update' and len(args) == 3:
        update(args[1], args[2])
    elif command == 'delete' and len(args) >= 2:
        delete(args[1:])
    elif command == 'initialize' and len(args) == 1:
        initialize()
    elif command == 'all' and len(args) == 1:
        all()
    elif command == 'participants' and len(args) == 1:
        participants()
    else:
        usage()
        return 1
    return 0

if __name__=='__main__':
    sys.exit(main(sys.argv[1:]))
