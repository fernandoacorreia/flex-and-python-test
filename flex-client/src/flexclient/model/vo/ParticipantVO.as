package flexclient.model.vo
{
    import mx.collections.ArrayCollection;
    
    [Bindable]
    public class ParticipantVO
    {
        public var projectCode:int = 0;
        public var participants:ArrayCollection = new ArrayCollection();        

        public function ParticipantVO(projectCode:int = 0, participants:Array = null)
        {
            if(projectCode != 0) this.projectCode = projectCode;
            if(participants != null) this.participants = new ArrayCollection(participants);
        } 
    }
}
