class ProjectService:
    def get(self, id):
        project_vo = {
            '_id': id,
            'manager': 'john',
        }
        return project_vo

    def get_all(self):
        return [{'_id': 1, 'manager': 'jacob'}, {'_id': 2, 'manager': 'joseph'}]
