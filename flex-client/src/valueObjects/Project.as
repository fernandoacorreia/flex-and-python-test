package valueObjects
{
	[Bindable]
	public class Project
	{
		public var _key:String;
		public var code:int;
		public var name:String;
		public var created_at:Date;
		public var modified_at:Date;
		
		public function Project()
		{
		}
	}
}
