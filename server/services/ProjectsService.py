# http://www.nabble.com/Python-Django-Google-App-Engine-De-serialization-Issue-td18221229.html
# obj_to_gae

import logging
from google.appengine.ext import db
from Model import Project

class ProjectsService:
    def get(self, code):
        logging.debug('get %s' % (code))
        project = Project.gql("WHERE code = :1", code).get()
        return project
        
    def insert(self, project):
        logging.debug('insert %s' % (project))
        new_project = Project()
        new_project.code = int(project.code)
        new_project.name = project.name
        new_project.department = int(project.department)
        new_project.put()
        return new_project

    def update(self, project):
        logging.debug('udpate %s' % (project))
        existing_project = Project.get(project._key)
        existing_project.name = project.name
        existing_project.department = int(project.department)
        existing_project.put()
        return Project.get(project._key)

    def save(self, project):
        logging.debug('save %s' % (project))
        if hasattr(project, '_key') and project._key != None:
            return self.update(project)
        else:
            return self.insert(project)

    def delete(self, project):
        logging.debug('delete %s' % (project))
        existing_project = Project.get(project._key)
        existing_project.delete()

    def get_all(self):
        logging.debug('get_all')
        return Project.all().fetch(1000)
