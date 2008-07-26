package flexclient.model.vo
{
    import mx.collections.ArrayCollection;
    
    [Bindable]
    public class ParticipantVO
    {
        public var projectKey:String;
        public var participants:ArrayCollection = new ArrayCollection();

        public function ParticipantVO(projectKey:String, participants:Array = null)
        {
            this.projectKey = projectKey;
            if(participants != null) this.participants = new ArrayCollection(participants);
        } 
    }
}
