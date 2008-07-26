package flexclient.view
{
    import flash.events.Event;
    
    import flexclient.ApplicationFacade;
    import flexclient.model.ProjectProxy;
    import flexclient.model.enum.DepartmentsEnum;
    import flexclient.model.vo.ProjectVO;
    import flexclient.view.components.ProjectForm;
    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.mediator.Mediator;

    public class ProjectFormMediator extends Mediator implements IMediator
    {
        private var projectProxy:ProjectProxy;
        
        public static const NAME:String = 'ProjectFormMediator';

        public function ProjectFormMediator(viewComponent:Object)
        {
            super(NAME, viewComponent);
            projectForm.addEventListener(ProjectForm.ADD, onAdd);
            projectForm.addEventListener(ProjectForm.UPDATE, onUpdate);
            projectForm.addEventListener(ProjectForm.CANCEL, onCancel);
            projectProxy = facade.retrieveProxy(ProjectProxy.NAME) as ProjectProxy;
        }
        
        private function get projectForm():ProjectForm
        {
            return viewComponent as ProjectForm;
        }
        
        private function onAdd(event:Event):void
        {
            var project:ProjectVO = projectForm.project;
            projectProxy.addItem(project);
            sendNotification(ApplicationFacade.PROJECT_ADDED, project);
            clearForm();
        }
        
        private function onUpdate(event:Event):void
        {
            var project:ProjectVO = projectForm.project;
            projectProxy.updateItem(project);
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
                    projectForm.project = note.getBody() as ProjectVO;
                    projectForm.mode = ProjectForm.MODE_ADD;
                    projectForm.code.setFocus();
                    break;
                    
                case ApplicationFacade.PROJECT_DELETED:
                    projectForm.project = null;
                    clearForm();
                    break;
                    
                case ApplicationFacade.PROJECT_SELECTED:
                    projectForm.project = note.getBody() as ProjectVO;
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