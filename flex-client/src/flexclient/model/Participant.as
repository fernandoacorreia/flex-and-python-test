package flexclient.model
{
    import mx.collections.ArrayCollection;
    
    [Bindable]
    public class Participant
    {
        public var projectKey:String;
        public var participants:ArrayCollection = new ArrayCollection();

        public function Participant(projectKey:String, participants:Array = null)
        {
            this.projectKey = projectKey;
            if(participants != null) this.participants = new ArrayCollection(participants);
        } 
    }
}
