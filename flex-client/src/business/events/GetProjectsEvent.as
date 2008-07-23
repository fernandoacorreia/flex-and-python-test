package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GetProjectsEvent extends CairngormEvent
	{
		static public var EVENT_ID:String = "GetProjectsEvent";
		
		public function GetProjectsEvent()
		{
			super(EVENT_ID);
		}
	}
}
