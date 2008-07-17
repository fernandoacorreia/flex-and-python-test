"""Flex and Python Test client

Usage:

client.py test
    Echo test.
client.py insert 1 "Project name"
    Inserts a new project with code = 1 and name = "Project name".
client.py get 1
    Gets a project with code = 1.
client.py all
    Lists all projects.
"""

import sys
from pyamf.remoting.client import RemotingService

def usage():
    print __doc__

def test():
    gw = RemotingService('http://localhost:8080/')
    service = gw.getService('EchoService')
    print service.echo('test')
    print service.echo_upper('test')
    print service.echo_upper(1)

def insert(code, name):
    gw = RemotingService('http://localhost:8080/')
    service = gw.getService('ProjectService')
    service.insert(int(code), name)

def get(code):
    gw = RemotingService('http://localhost:8080/')
    service = gw.getService('ProjectService')
    project = service.get(int(code))
    if project == None:
        print "Project %s not found." % (code)
    else:
        print_project(project)

def all():
    gw = RemotingService('http://localhost:8080/')
    service = gw.getService('ProjectService')
    projects = service.get_all()
    for project in projects:
        print_project(project)
        
def print_project(project):
    print "Project code = %s, name = %s, created at %s" % (project.code, project.name, project.created_at)

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
    elif command == 'all' and len(args) == 1:
        all()
    else:
        usage()
        return 1
    return 0

if __name__=='__main__':
    sys.exit(main(sys.argv[1:]))
