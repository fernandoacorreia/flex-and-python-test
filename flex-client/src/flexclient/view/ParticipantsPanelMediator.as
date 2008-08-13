package flexclient.view
{
    import flash.events.Event;    
    import flexclient.ApplicationFacade;
    import flexclient.model.Participant;
    import flexclient.model.ParticipantsProxy;
    import flexclient.model.Project;
    import flexclient.view.components.ParticipantsPanel;
    import mx.utils.StringUtil;    
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.mediator.Mediator;

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
            var newParticipant:Participant = new Participant();
            newParticipant.projectKey = participantsPanel.project._key;
            newParticipant.name = StringUtil.trim(participantsPanel.newParticipant.text);
            participantsProxy.addParticipant(newParticipant);
            participantsPanel.newParticipant.text = "";
        }
        
        private function onRemoveParticipant(event:Event):void
        {
            var selectedParticipant:Participant;
            selectedParticipant = participantsPanel.participantList.selectedItem as Participant;
            participantsProxy.deleteParticipant(selectedParticipant);
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
                    ApplicationFacade.PARTICIPANT_ADDED
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
                    participantsPanel.newParticipant.text = "";
                    break;
                    
                case ApplicationFacade.PARTICIPANT_ADDED:
                    participantsPanel.projectParticipants = null;
                    participantsPanel.projectParticipants = participantsProxy.getProjectParticipants(participantsPanel.project._key);
                    break;
            }
        }
        
        private function clearForm():void
        {        
            participantsPanel.project = null;
            participantsPanel.projectParticipants = null;
            participantsPanel.newParticipant.text = "";
        }
    }
}