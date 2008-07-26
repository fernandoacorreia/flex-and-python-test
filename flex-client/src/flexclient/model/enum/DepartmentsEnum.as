package flexclient.model.enum
{    
    [Bindable]
    public class DepartmentsEnum
    {
        public static const NONE_SELECTED:DepartmentsEnum = new DepartmentsEnum(-1, '(None Selected)');
        public static const ACCT:DepartmentsEnum          = new DepartmentsEnum(0, 'Accounting');
        public static const SALES:DepartmentsEnum         = new DepartmentsEnum(1, 'Sales');
        public static const PLANT:DepartmentsEnum         = new DepartmentsEnum(2, 'Plant');
        public static const SHIPPING:DepartmentsEnum      = new DepartmentsEnum(3, 'Shipping');
        public static const QC:DepartmentsEnum            = new DepartmentsEnum(4, 'Quality Control');
        
        public var ordinal:int;
        public var value:String;
        
        public function DepartmentsEnum(ordinal:int, value:String)
        {
            this.ordinal = ordinal;
            this.value = value;
        }

        public static function get list():Array
        {
            return [ ACCT, 
                     SALES, 
                     PLANT,
                     SHIPPING,
                     QC
                   ];
        }

        public static function get comboList():Array
        {
            var cList:Array = DepartmentsEnum.list;
            cList.unshift(NONE_SELECTED);
            return cList;
        }
        
        public function equals(enum:DepartmentsEnum):Boolean
        {
            return(this.ordinal == enum.ordinal && this.value == enum.value);
        }
    }
}
