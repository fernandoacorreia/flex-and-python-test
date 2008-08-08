package flexclient.model
{
    [Bindable]
    public class Participant
    {
        public var _key:String;
        public var projectKey:String;
        public var name:String;
        public var created_at:Date;
        public var modified_at:Date;

        public static function fromDto(dto:Object = null):Participant
        {
        	var participant:Participant = new Participant();
            participant._key = dto._key;
            participant.projectKey = dto.project_key;
            participant.name = dto.name;
            participant.created_at = dto.created_at;
            participant.modified_at = dto.modified_at;
            return participant;
        }
        
        public function toDto():Object
        {
            var dto:Object = new Object();
            dto._key = _key;
            dto.projectKey = projectKey;
            dto.name = name;
            dto.modified_at = modified_at;
            return dto;
        }
    }
}
