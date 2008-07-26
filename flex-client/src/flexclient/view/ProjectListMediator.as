package flexclient.view
{
    import flash.events.Event;
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.mediator.Mediator;
    import org.puremvc.as3.patterns.observer.Notification;
    import flexclient.ApplicationFacade;
    import flexclient.model.vo.ProjectVO;
    import flexclient.model.ProjectProxy;
    import flexclient.view.components.ProjectList;

    public class ProjectListMediator extends Mediator implements IMediator
    {
        private var projectProxy:ProjectProxy;

        public static const NAME:String = 'ProjectListMediator';

        public function ProjectListMediator(viewComponent:Object)
        {
            super(NAME, viewComponent);
            
            projectList.addEventListener(ProjectList.NEW, onNew);
            projectList.addEventListener(ProjectList.DELETE, onDelete);
            projectList.addEventListener(ProjectList.SELECT, onSelect);

            projectProxy = facade.retrieveProxy(ProjectProxy.NAME) as ProjectProxy;
            projectList.projects = projectProxy.projects;
        }
        
        private function get projectList():ProjectList
        {
            return viewComponent as ProjectList;
        }
        
        private function onNew(event:Event):void
        {
            var project:ProjectVO = new ProjectVO();
            sendNotification(ApplicationFacade.NEW_PROJECT, project);
        }
        
        private function onDelete(event:Event):void
        {
            sendNotification(ApplicationFacade.DELETE_PROJECT,
                             projectList.selectedProject);
        }
        
        private function onSelect(event:Event):void
        {
            sendNotification(ApplicationFacade.PROJECT_SELECTED,
                             projectList.selectedProject);
        }

        override public function listNotificationInterests():Array
        {
            return [
                    ApplicationFacade.CANCEL_SELECTED,
                    ApplicationFacade.PROJECT_UPDATED
                   ];
        }
        
        override public function handleNotification(note:INotification):void
        {
            switch (note.getName())
            {
                case ApplicationFacade.CANCEL_SELECTED:
                    projectList.deSelect();
                    break;
                    
                case ApplicationFacade.PROJECT_UPDATED:
                    projectList.deSelect();
                    break;                    
            }
        }
    }
}