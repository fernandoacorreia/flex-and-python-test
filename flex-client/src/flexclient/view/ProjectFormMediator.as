package flexclient.view
{
    import flash.events.Event;
    
    import flexclient.ApplicationFacade;
    import flexclient.model.ProjectsProxy;
    import flexclient.model.enum.DepartmentsEnum;
    import flexclient.model.Project;
    import flexclient.view.components.ProjectForm;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.mediator.Mediator;

    public class ProjectFormMediator extends Mediator implements IMediator
    {
        private var projectsProxy:ProjectsProxy;
        
        public static const NAME:String = 'ProjectFormMediator';

        public function ProjectFormMediator(viewComponent:Object)
        {
            super(NAME, viewComponent);
            projectForm.addEventListener(ProjectForm.ADD, onAdd);
            projectForm.addEventListener(ProjectForm.UPDATE, onUpdate);
            projectForm.addEventListener(ProjectForm.CANCEL, onCancel);
            projectsProxy = facade.retrieveProxy(ProjectsProxy.NAME) as ProjectsProxy;
        }
        
        private function get projectForm():ProjectForm
        {
            return viewComponent as ProjectForm;
        }
        
        private function onAdd(event:Event):void
        {
            var project:Project = projectForm.project;
            projectsProxy.addItem(project);
            sendNotification(ApplicationFacade.PROJECT_ADDED, project);
            clearForm();
        }
        
        private function onUpdate(event:Event):void
        {
            var project:Project = projectForm.project;
            projectsProxy.updateItem(project);
            sendNotification(ApplicationFacade.PROJECT_UPDATED, project);
            clearForm();
        }
        
        private function onCancel(event:Event):void
        {
            sendNotification(ApplicationFacade.CANCEL_SELECTED);
            clearForm();
        }
        
        override public function listNotificationInterests():Array
        {
            return [
                    ApplicationFacade.NEW_PROJECT,
                    ApplicationFacade.PROJECT_DELETED,
                    ApplicationFacade.PROJECT_SELECTED                    
                   ];
        }
        
        override public function handleNotification(note:INotification):void
        {
            switch (note.getName())
            {
                case ApplicationFacade.NEW_PROJECT:
                    projectForm.project = note.getBody() as Project;
                    projectForm.mode = ProjectForm.MODE_ADD;
                    projectForm.code.setFocus();
                    break;
                    
                case ApplicationFacade.PROJECT_DELETED:
                    projectForm.project = null;
                    clearForm();
                    break;
                    
                case ApplicationFacade.PROJECT_SELECTED:
                    projectForm.project = note.getBody() as Project;
                    projectForm.mode = ProjectForm.MODE_EDIT;
                    projectForm.project_name.setFocus();
                    break;
            }
        }
        
        private function clearForm():void
        {
            projectForm.project = null;
            projectForm.code.text = '';
            projectForm.project_name.text = '';
            projectForm.department.selectedItem = DepartmentsEnum.NONE_SELECTED;
        }
    }
}