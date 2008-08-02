import logging
from google.appengine.ext import db
from Model import Project, ProjectParticipant, DTO

class ProjectParticipantsService:
    def get(self, key):
        logging.debug('get %s' % (key))
        return self.to_dto(ProjectParticipant.get(key))

    def insert(self, participant_dto):
        logging.debug('insert %s' % (participant_dto))
        participant = ProjectParticipant()
        participant.project = Project.get(participant_dto.project_key)
        participant.name = participant_dto.name
        participant.put()
        return self.to_dto(participant)

    def update(self, participant_dto):
        logging.debug('update %s' % (participant_dto))
        participant = ProjectParticipant.get(participant_dto._key)
        participant.name = participant_dto.name
        participant.put()
        return self.to_dto(ProjectParticipant.get(participant_dto._key))

    def save(self, participant_dto):
        logging.debug('save %s' % (participant_dto))
        if hasattr(participant_dto, '_key') and participant_dto._key != None:
            return self.update(participant_dto)
        else:
            return self.insert(participant_dto)

    def delete(self, participant_dto):
        logging.debug('delete %s' % (participant_dto))
        participant = ProjectParticipant.get(participant_dto._key)
        participant.delete()

    def get_all(self):
        logging.debug('get_all')
        participants = ProjectParticipant.all().fetch(1000)
        participants_dto = []
        for participant in participants:
            participants_dto.append(self.to_dto(participant))
        return participants_dto

    def to_dto(self, participant):
        if participant is None: return None
        dto = DTO()
        dto._key = str(participant.key())
        dto._id = participant.key().id()
        dto.project_key = str(participant.project.key())
        dto.name = participant.name
        dto.created_at = participant.created_at
        dto.modified_at = participant.modified_at
        return dto
