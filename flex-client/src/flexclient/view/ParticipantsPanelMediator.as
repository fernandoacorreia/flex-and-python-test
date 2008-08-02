package flexclient.view
{
    import flash.events.Event;
    import mx.collections.ArrayCollection;
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.mediator.Mediator;
    import org.puremvc.as3.patterns.observer.Notification;
    import flexclient.ApplicationFacade;
    import flexclient.model.Project;
    import flexclient.model.ParticipantsProxy;
    import flexclient.model.Participant;
    import flexclient.model.enum.ParticipantsEnum;
    import flexclient.view.components.ParticipantsPanel;

    public class ParticipantsPanelMediator extends Mediator implements IMediator
    {
        private var participantsProxy:ParticipantsProxy;
        
        public static const NAME:String = 'ParticipantPanelMediator';

        public function ParticipantsPanelMediator(viewComponent:Object)
        {
            super(NAME, viewComponent);            
            participantsPanel.addEventListener(ParticipantsPanel.ADD, onAddParticipant);
            participantsPanel.addEventListener(ParticipantsPanel.REMOVE, onRemoveParticipant);
            participantsProxy = facade.retrieveProxy(ParticipantsProxy.NAME) as ParticipantsProxy;
                
        }
        
        private function get participantsPanel():ParticipantsPanel
        {
            return viewComponent as ParticipantsPanel;
        }
        
        private function onAddParticipant(event:Event):void
        {
            participantsProxy.addParticipantToProject(participantsPanel.project, participantsPanel.selectedParticipant);
        }
        
        private function onRemoveParticipant(event:Event):void
        {
            participantsProxy.removeParticipantFromProject(participantsPanel.project, participantsPanel.selectedParticipant);
        }
        
        override public function listNotificationInterests():Array
        {
            return [
                    ApplicationFacade.NEW_PROJECT,
                    ApplicationFacade.PROJECT_ADDED,
                    ApplicationFacade.PROJECT_UPDATED,
                    ApplicationFacade.PROJECT_DELETED,
                    ApplicationFacade.CANCEL_SELECTED,
                    ApplicationFacade.PROJECT_SELECTED,
                    ApplicationFacade.PARTICIPANT_ADDED_TO_PROJECT
                   ];
        }
        
        override public function handleNotification(note:INotification):void
        {

            switch (note.getName())
            {
                case ApplicationFacade.NEW_PROJECT:
                    clearForm();
                    break;
                    
                case ApplicationFacade.PROJECT_ADDED:
                    participantsPanel.project = note.getBody() as Project;
                    var participantVO:Participant = new Participant(participantsPanel.project._key);
                    participantsProxy.addItem(participantVO);
                    clearForm();
                    break;
                    
                case ApplicationFacade.PROJECT_UPDATED:
                    clearForm();
                    break;
                    
                case ApplicationFacade.PROJECT_DELETED:
                    clearForm();
                    break;
                    
                case ApplicationFacade.CANCEL_SELECTED:
                    clearForm();
                    break;
                    
                case ApplicationFacade.PROJECT_SELECTED:
                    participantsPanel.project = note.getBody() as Project;
                    participantsPanel.projectParticipants = participantsProxy.getProjectParticipants(participantsPanel.project._key);
                    participantsPanel.participantCombo.selectedItem = ParticipantsEnum.NONE_SELECTED;
                    break;
                    
                case ApplicationFacade.PARTICIPANT_ADDED_TO_PROJECT:
                    participantsPanel.projectParticipants = null;
                    participantsPanel.projectParticipants = participantsProxy.getProjectParticipants(participantsPanel.project._key);
                    break;
            }
        }
        
        private function clearForm():void
        {        
            participantsPanel.project = null;
            participantsPanel.projectParticipants = null;
            participantsPanel.participantCombo.selectedItem = ParticipantsEnum.NONE_SELECTED;
        }
    }
}