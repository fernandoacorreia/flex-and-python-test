package flexclient.model
{
    import flash.net.Responder;
    
    import flexclient.ApplicationFacade;
    
    import mx.collections.ArrayCollection;
    import mx.controls.Alert;
    
    import org.puremvc.as3.patterns.proxy.Proxy;

    public class ParticipantsProxy extends Proxy
    {
        public static const NAME:String = 'ParticipantsProxy';

        public function ParticipantsProxy()
        {
            super(NAME, new Object());
            ServiceGateway.GetConnection().call("ProjectParticipantsService.get_all", new Responder(onGetAllResult, onFault));
        }
        
        private function onGetAllResult(result:Array):void
        {
            for (var i:int = 0; i < result.length; i++)
            {
            	var participant:Participant = Participant.fromDto(result[i]);
            	var participants:ArrayCollection = getProjectParticipants(participant.projectKey);
            	participants.addItem(participant);
            }
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
        }
        
        private function onAddParticipantResult(result:Object):void
        {
        	var participant:Participant = Participant.fromDto(result);
        	var projectParticipants:ArrayCollection = getProjectParticipants(participant.projectKey);
            projectParticipants.addItem(participant);
            sendNotification(ApplicationFacade.PARTICIPANT_ADDED, participant);
        }
        
		public function onFault(fault:Object) : void 
		{
			var message:String;
			if (fault.description != undefined)
			    message = fault.code + ": " + fault.description;
			else
			    message = fault.toString();
			Alert.show('Error: ' + message);
		}
        
        // Deletes an item from the data.
        public function deleteParticipant(participant:Participant):void
        {
            ServiceGateway.GetConnection().call("ProjectParticipantsService.delete", new Responder(null, onFault), participant.toDto());
            var projectParticipants:ArrayCollection = getProjectParticipants(participant.projectKey);
            for (var i:int = 0; i < projectParticipants.length; i++) { 
                var currentParticipant:Participant = projectParticipants.getItemAt(i) as Participant;
                if (currentParticipant._key == participant._key) {
                    projectParticipants.removeItemAt(i);
                    break;
                }
            }
        }
        
        public function deleteParticipants(project:Project):void
        {
            var projectParticipants:ArrayCollection = getProjectParticipants(project._key);
            for (var i:int = 0; i < projectParticipants.length; i++) { 
                var currentParticipant:Participant = projectParticipants.getItemAt(i) as Participant;
                ServiceGateway.GetConnection().call("ProjectParticipantsService.delete", new Responder(null, onFault), currentParticipant.toDto());
            }
            projectParticipants.removeAll();
        }
    }
}
