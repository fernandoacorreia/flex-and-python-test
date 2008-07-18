import logging
from google.appengine.ext import db

class Project(db.Model):
    code = db.IntegerProperty()
    name = db.StringProperty()
    created_at = db.DateTimeProperty(auto_now_add=True)

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

    def get_all(self):
        logging.debug('get_all')
        return Project.all().fetch(1000)
