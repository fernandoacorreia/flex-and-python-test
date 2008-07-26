package flexclient.controller
{
    import mx.controls.Alert;
    import org.puremvc.as3.interfaces.ICommand;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    import org.puremvc.as3.patterns.observer.Notification;
    import flexclient.ApplicationFacade;
    import flexclient.model.ProjectProxy;
    import flexclient.model.ParticipantProxy;
    import flexclient.model.vo.ProjectVO;

    public class DeleteProjectCommand extends SimpleCommand implements ICommand
    {
        // Deletes the project and its participants.
        // Then sends the PROJECT_DELETED notification.
        override public function execute(notification:INotification):void
        {
            var project:ProjectVO = notification.getBody() as ProjectVO;
            var projectProxy:ProjectProxy = facade.retrieveProxy(ProjectProxy.NAME) as ProjectProxy;
            var participantProxy:ParticipantProxy = facade.retrieveProxy(ParticipantProxy.NAME) as ParticipantProxy;
            projectProxy.deleteItem(project);
            participantProxy.deleteItem(project);
            sendNotification(ApplicationFacade.PROJECT_DELETED);
        }
    }
}
