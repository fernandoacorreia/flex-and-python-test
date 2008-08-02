package flexclient.model
{
    import mx.collections.ArrayCollection;
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;
    import org.puremvc.as3.patterns.observer.Notification;
    import flexclient.model.Participant;
    import flexclient.model.Project;
    import flexclient.model.enum.ParticipantsEnum;
    import flexclient.ApplicationFacade;

    public class ParticipantsProxy extends Proxy
    {
        public static const NAME:String = 'ParticipantsProxy';

        public function ParticipantsProxy()
        {
            super(NAME, new ArrayCollection);            
        }
        
        // Gets the data property cast to the appropriate type.
        public function get participants():ArrayCollection
        {
            return data as ArrayCollection;
        }

        // Adds an item to the data.
        public function addItem(item:Object):void
        {
            participants.addItem(item);
        }
        
        // Deletes an item from the data.
        public function deleteItem(item:Object):void
        {
            for (var i:int = 0; i < participants.length; i++) { 
                if (participants.getItemAt(i).projectKey == item._key) {
                    participants.removeItemAt(i);
                    break;
                }
            }
        }

        // Determines if the project has a given participant.
        public function doesProjectHaveParticipant(project:Project, participant:ParticipantsEnum):Boolean
        {
        	var projectParticipants:ArrayCollection = getProjectParticipants(project._key);
            var hasParticipant:Boolean = false;
            for (var i:int = 0; i < projectParticipants.length; i++) {
                if (ParticipantsEnum(projectParticipants.getItemAt(i)).equals(participant)) {
                    return true;
                }
            }
            return false;
        }

        // Adds a participant to a project.
        public function addParticipantToProject(project:Project, participant:ParticipantsEnum) : void
        {
            var result:Boolean = false;
            if (!doesProjectHaveParticipant(project, participant)) {
	        	var projectParticipants:ArrayCollection = getProjectParticipants(project._key);
				projectParticipants.addItem(participant);
                result = true;
            }
            sendNotification(ApplicationFacade.PARTICIPANT_ADDED_TO_PROJECT, result);
        }

        // Removes a participant from a project.
        public function removeParticipantFromProject(project:Project, participant:ParticipantsEnum) : void
        {
            if (doesProjectHaveParticipant(project, participant)) {
	        	var projectParticipants:ArrayCollection = getProjectParticipants(project._key);
                for (var i:int = 0; i < projectParticipants.length; i++) { 
                    if (ParticipantsEnum(projectParticipants.getItemAt(i)).equals(participant)) {
                        projectParticipants.removeItemAt(i);
                        break;
                    }
                }
            }
        }

        // Gets a project's participants.
        public function getProjectParticipants(key:String):ArrayCollection
        {
            for (var i:int = 0; i < participants.length; i++) {
                if (participants.getItemAt(i).projectKey == key) {
                    return participants.getItemAt(i).participants as ArrayCollection;
                }
            }
            // there is no list of participants for the project, so create one
            var newParticipant:Participant = new Participant(key);
            participants.addItem(newParticipant);
            return newParticipant.participants as ArrayCollection;
        }
    }
}
