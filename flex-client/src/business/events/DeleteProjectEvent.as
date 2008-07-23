package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class DeleteProjectEvent extends CairngormEvent
	{
		static public var EVENT_ID:String = "DeleteProjectEvent";
		public var project:Object = null;
		
		public function DeleteProjectEvent(project:Object)
		{
			super(EVENT_ID);
			this.project = project;
		}
	}
}
