package flexclient.model
{
    import mx.collections.ArrayCollection;
    import flexclient.model.enum.DepartmentsEnum;
    
    [Bindable]
    public class Project
    {
    	public var _key:String;
        public var code:int;
        public var name:String;
        public var department:int;
        public var created_at:Date;
        public var modified_at:Date;
        
        public function Project(dto:Object = null)
        {
        	if (dto == null) return;
			_key = dto._key;
			code = dto.code;
			name = dto.name;
            department = dto.department;
			created_at = dto.created_at;
			modified_at = dto.modified_at;
        }

        public function get isValid():Boolean
        {
            return code != 0 && name != '' && department != 0;
        }
    }
}
