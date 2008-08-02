package flexclient.controller
{
    import mx.controls.Alert;
    import org.puremvc.as3.interfaces.ICommand;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    import org.puremvc.as3.patterns.observer.Notification;
    import flexclient.ApplicationFacade;
    import flexclient.model.ProjectsProxy;
    import flexclient.model.ParticipantsProxy;
    import flexclient.model.Project;

    public class DeleteProjectCommand extends SimpleCommand implements ICommand
    {
        // Deletes the project and its participants.
        // Then sends the PROJECT_DELETED notification.
        override public function execute(notification:INotification):void
        {
            var project:Project = notification.getBody() as Project;
            var projectsProxy:ProjectsProxy = facade.retrieveProxy(ProjectsProxy.NAME) as ProjectsProxy;
            var participantsProxy:ParticipantsProxy = facade.retrieveProxy(ParticipantsProxy.NAME) as ParticipantsProxy;
            projectsProxy.deleteItem(project);
            participantsProxy.deleteItem(project);
            sendNotification(ApplicationFacade.PROJECT_DELETED);
        }
    }
}
