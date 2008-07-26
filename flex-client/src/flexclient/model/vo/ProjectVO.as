package flexclient.model.vo
{
    import mx.collections.ArrayCollection;
    import flexclient.model.enum.DepartmentsEnum;
    
    [Bindable]
    public class ProjectVO
    {
    	public var _key:String;
        public var code:int;
        public var name:String;
        public var created_at:Date;
        public var modified_at:Date;
        public var department:int;
        
        public function ProjectVO(dto:Object = null)
        {
        	if (dto == null) return;
			_key = dto._key;
			code = dto.code;
			name = dto.name;
			created_at = dto.created_at;
			modified_at = dto.modified_at;
			department = dto.department;
        }

        public function get isValid():Boolean
        {
            return code != 0 && name != '' && department != 0;
        }
    }
}
