import cgi
import os
import wsgiref.handlers

from google.appengine.ext import db
from google.appengine.ext import webapp
from google.appengine.ext.webapp import template
from services.Model import Project, ProjectParticipant

class MainPage(webapp.RequestHandler):
  def get(self):
    projects = Project.all().order('name')
    template_values = {
        'projects': projects,
    }
    path = os.path.join(os.path.dirname(__file__), 'index.html')
    self.response.out.write(template.render(path, template_values))

def main():
    application = webapp.WSGIApplication([('/', MainPage)],
                                         debug=True)
    wsgiref.handlers.CGIHandler().run(application)
  
if __name__ == "__main__":
  main()
