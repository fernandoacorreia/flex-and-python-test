# http://www.nabble.com/Python-Django-Google-App-Engine-De-serialization-Issue-td18221229.html
# obj_to_gae

import logging
from google.appengine.ext import db

class Project(db.Model):
    code = db.IntegerProperty()
    name = db.StringProperty()
    created_at = db.DateTimeProperty(auto_now_add=True)
    modified_at = db.DateTimeProperty(auto_now=True)

class ProjectService:
    def get(self, code):
        logging.debug('get %s' % (code))
        project = Project.gql("WHERE code = :1", code).get()
        return project
        
    def insert(self, project):
        logging.debug('insert %s' % (project))
        new_project = Project()
        new_project.code = int(project.code)
        new_project.name = project.name
        new_project.put()
        return new_project

    def update(self, project):
        logging.debug('udpate %s' % (project))
        existing_project = Project.get(project._key)
        existing_project.name = project.name
        existing_project.put()
        return Project.get(project._key)

    def save(self, project):
        logging.debug('save %s' % (project))
        if hasattr(project, '_key') and project._key != None:
            return self.update(project)
        else:
            return self.insert(project)

    def get_all(self):
        logging.debug('get_all')
        return Project.all().fetch(1000)
