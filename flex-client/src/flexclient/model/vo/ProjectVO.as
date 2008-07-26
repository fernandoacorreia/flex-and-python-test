package flexclient.model.vo
{
    import mx.collections.ArrayCollection;
    import flexclient.model.enum.DepartmentsEnum;
    
    [Bindable]
    public class ProjectVO
    {
        public var code:int = 0;
        public var name:String = '';
        public var department:DepartmentsEnum = DepartmentsEnum.NONE_SELECTED;

        public function ProjectVO(code:int = 0,
                                  name:String = null,
                                  department:DepartmentsEnum = null)
        {
            if(code != 0) this.code = code;
            if(name != null) this.name = name;
            if(department != null) this.department = department;
        }
        
        public function get isValid():Boolean
        {
            return code != 0 && name != '' && department != DepartmentsEnum.NONE_SELECTED;
        }
        
        public function get givenName():String
        {
            return this.name;
        }
    }
}
