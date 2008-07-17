from google.appengine.ext import db

class Project(db.Model):
    code = db.IntegerProperty()
    name = db.StringProperty()
    created_at = db.DateTimeProperty(auto_now_add=True)

class ProjectService:
    def get(self, code):
        project = Project.gql("WHERE code = :1", code).get()
        return project
        
    def insert(self, code, name):
        project = Project()
        project.code = code
        project.name = name
        project.put()

    def get_all(self):
        return Project.all().fetch(1000)
