package flexclient.model
{
    import flash.net.NetConnection;
    import flash.net.Responder; 
    import flexclient.ApplicationFacade;    
    import flexclient.model.ServiceGateway;
    import mx.collections.ArrayCollection;
    import mx.controls.Alert;    
    import org.puremvc.as3.patterns.proxy.Proxy;

    public class ParticipantsProxy extends Proxy
    {
        public static const NAME:String = 'ParticipantsProxy';

        public function ParticipantsProxy()
        {
            super(NAME, new Object());
        }
        
        // Gets the data property cast to the appropriate type.
        public function get participants():Object
        {
            return data as Object;
        }
        
        public function getProjectParticipants(projectKey:String):ArrayCollection
        {
            if (participants[projectKey] == undefined)
               participants[projectKey] = new ArrayCollection;
        	return participants[projectKey] as ArrayCollection;
        }

        // Adds an item to the data.
        public function addParticipant(participant:Participant):void
        {
        	ServiceGateway.GetConnection().call("ProjectParticipantsService.save", new Responder(onAddParticipantResult, onFault), participant.toDto());
        	var projectParticipants:ArrayCollection = getProjectParticipants(participant.projectKey);
            projectParticipants.addItem(participant);
        }
        
        private function onAddParticipantResult(result:Object):void
        {
        	var participant:Participant = Participant.fromDto(result);
        	var projectParticipants:ArrayCollection = getProjectParticipants(participant.projectKey);
            projectParticipants.addItem(participant);
            sendNotification(ApplicationFacade.PARTICIPANT_ADDED, participant);
        }
        
		public function onFault(fault:String) : void 
		{
			Alert.show('Error: ' + fault);
		}
        
        // Deletes an item from the data.
        public function deleteParticipant(participant:Participant):void
        {
            var projectParticipants:ArrayCollection = getProjectParticipants(participant.projectKey);
            for (var i:int = 0; i < projectParticipants.length; i++) { 
                var currentParticipant:Participant = projectParticipants.getItemAt(i) as Participant;
                if (currentParticipant._key == participant._key) {
                    projectParticipants.removeItemAt(i);
                    ServiceGateway.GetConnection().call("ProjectParticipantsService.delete", new Responder(onDeleteParticipantResult, onFault), participant.toDto());
                    break;
                }
            }
        }

        private function onDeleteParticipantResult(result:Object):void
        {
        	// TODO
        }
    }
}
