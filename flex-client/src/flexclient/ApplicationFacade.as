package flexclient
{
    import org.puremvc.as3.interfaces.IFacade;
    import org.puremvc.as3.patterns.facade.Facade;
    import org.puremvc.as3.patterns.observer.Notification;
    import flexclient.controller.*;
    
    public class ApplicationFacade extends Facade implements IFacade
    {
        // Notification name constants
        public static const STARTUP:String = "STARTUP";
        
        public static const NEW_PROJECT:String = "NEW_PROJECT";
        public static const DELETE_PROJECT:String = "DELETE_PROJECT";
        public static const CANCEL_SELECTED:String = "CANCEL_SELECTED";
        
        public static const PROJECT_SELECTED:String = "PROJECT_SELECTED";
        public static const PROJECT_ADDED:String = "PROJECT_ADDED";
        public static const PROJECT_UPDATED:String = "PROJECT_UPDATED";
        public static const PROJECT_DELETED:String = "PROJECT_DELETED";

        public static const ADD_PARTICIPANT:String = "ADD_PARTICIPANT";
        public static const PARTICIPANT_ADDED_TO_PROJECT:String = "PARTICIPANT_ADDED_TO_PROJECT";
        
        /**
         * Singleton ApplicationFacade Factory Method.
         */
        public static function getInstance() : ApplicationFacade {
            if (instance == null) instance = new ApplicationFacade();
            return instance as ApplicationFacade;
        }
        
        /**
         * Starts the application.
         */
         public function startup(app:Object):void
         {
             sendNotification(STARTUP, app);    
         }

        /**
         * Registers Commands with the Controller.
         */
        override protected function initializeController() : void 
        {
            super.initializeController();            
            registerCommand(STARTUP, StartupCommand);
            registerCommand(DELETE_PROJECT, DeleteProjectCommand);
            registerCommand(PARTICIPANT_ADDED_TO_PROJECT, ParticipantAddedToProjectCommand);
        }
    }
}
