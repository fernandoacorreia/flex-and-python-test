import logging
from google.appengine.ext import db
from Model import Project, DTO

class ProjectsService:
    def get(self, key):
        logging.debug('get %s' % (key))
        return self.to_dto(Project.get(key))

    def get_by_code(self, code):
        logging.debug('get_by_code %s' % (code))
        return self.to_dto(Project.gql("WHERE code = :1", code).get())
        
    def insert(self, project_dto):
        logging.debug('insert %s' % (project_dto))
        project = Project()
        project.code = int(project_dto.code)
        project.name = project_dto.name
        project.department = int(project_dto.department)
        project.put()
        return self.to_dto(project)

    def update(self, project_dto):
        logging.debug('update %s' % (project_dto))
        project = Project.get(project_dto._key)
        project.name = project_dto.name
        project.department = int(project_dto.department)
        project.put()
        return self.to_dto(Project.get(project_dto._key))

    def save(self, project_dto):
        logging.debug('save %s' % (project_dto))
        if hasattr(project_dto, '_key') and project_dto._key != None:
            return self.update(project_dto)
        else:
            return self.insert(project_dto)

    def delete(self, project_dto):
        logging.debug('delete %s' % (project_dto))
        project = Project.get(project_dto._key)
        project.delete()

    def get_all(self):
        logging.debug('get_all')
        projects = Project.all().fetch(1000)
        projects_dto = []
        for project in projects:
            projects_dto.append(self.to_dto(project))
        return projects_dto

    def to_dto(self, project):
        if project is None: return None
        dto = DTO()
        dto._key = str(project.key())
        dto._id = project.key().id()
        dto.code = project.code
        dto.name = project.name
        dto.department = project.department
        dto.created_at = project.created_at
        dto.modified_at = project.modified_at
        return dto
