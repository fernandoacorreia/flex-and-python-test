package flexclient.view
{
    import flash.events.Event;
    import mx.collections.ArrayCollection;
    import org.puremvc.as3.interfaces.IMediator;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.mediator.Mediator;
    import org.puremvc.as3.patterns.observer.Notification;
    import flexclient.ApplicationFacade;
    import flexclient.model.vo.ProjectVO;
    import flexclient.model.ParticipantProxy;
    import flexclient.model.vo.ParticipantVO;
    import flexclient.model.enum.ParticipantsEnum;
    import flexclient.view.components.ParticipantsPanel;

    public class ParticipantsPanelMediator extends Mediator implements IMediator
    {
        private var participantProxy:ParticipantProxy;        
        
        public static const NAME:String = 'ParticipantPanelMediator';

        public function ParticipantsPanelMediator(viewComponent:Object)
        {
            super(NAME, viewComponent);            
            participantsPanel.addEventListener(ParticipantsPanel.ADD, onAddParticipant);
            participantsPanel.addEventListener(ParticipantsPanel.REMOVE, onRemoveParticipant);
            participantProxy = facade.retrieveProxy(ParticipantProxy.NAME) as ParticipantProxy;
                
        }
        
        private function get participantsPanel():ParticipantsPanel
        {
            return viewComponent as ParticipantsPanel;
        }
        
        private function onAddParticipant(event:Event):void
        {
            participantProxy.addParticipantToProject(participantsPanel.project, participantsPanel.selectedParticipant);
        }
        
        private function onRemoveParticipant(event:Event):void
        {
            participantProxy.removeParticipantFromProject(participantsPanel.project, participantsPanel.selectedParticipant);
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
                    participantsPanel.project = note.getBody() as ProjectVO;
                    var participantVO:ParticipantVO = new ParticipantVO(participantsPanel.project.code);
                    participantProxy.addItem(participantVO);
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
                    participantsPanel.project = note.getBody() as ProjectVO;
                    participantsPanel.projectParticipants = participantProxy.getProjectParticipants(participantsPanel.project.code);
                    participantsPanel.participantCombo.selectedItem = ParticipantsEnum.NONE_SELECTED;
                    break;
                    
                case ApplicationFacade.PARTICIPANT_ADDED_TO_PROJECT:
                    participantsPanel.projectParticipants = null;
                    participantsPanel.projectParticipants = participantProxy.getProjectParticipants(participantsPanel.project.code);
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