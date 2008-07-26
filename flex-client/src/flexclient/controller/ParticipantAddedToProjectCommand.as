package flexclient.controller
{
    import mx.controls.Alert;
    import org.puremvc.as3.interfaces.ICommand;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    public class ParticipantAddedToProjectCommand extends SimpleCommand implements ICommand
    {
        override public function execute(notification:INotification):void
        {
            var result:Boolean = notification.getBody() as Boolean;
            if (result == false) {
                Alert.show('Could not add the participant to the project.','Add Project Participant');
            }
        }
    }
}
