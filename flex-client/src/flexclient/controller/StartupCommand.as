package flexclient.controller
{
    import org.puremvc.as3.interfaces.ICommand;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;    
    import flexclient.model.ProjectProxy;
    import flexclient.model.ParticipantProxy;
    import flexclient.ApplicationFacade;
    import flexclient.view.ProjectFormMediator;
    import flexclient.view.ProjectListMediator;
    import flexclient.view.ParticipantsPanelMediator;

    public class StartupCommand extends SimpleCommand implements ICommand
    {
        /**
         * Registers the Proxies and Mediators.
         * 
         * Gets the View Components for the Mediators from the app,
         * which passed a reference to itself on the notification.
         */
        override public function execute(note:INotification) : void
        {
            facade.registerProxy(new ProjectProxy());
            facade.registerProxy(new ParticipantProxy());
            var app:FlexClient = note.getBody() as FlexClient;
            facade.registerMediator(new ProjectFormMediator(app.projectForm));
            facade.registerMediator(new ProjectListMediator(app.projectList));
            facade.registerMediator(new ParticipantsPanelMediator(app.participantsPanel));
        }
    }
}
