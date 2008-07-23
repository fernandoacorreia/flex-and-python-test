package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class NewProjectEvent extends CairngormEvent
	{
		static public var EVENT_ID:String = "NewProjectEvent";
		
		public function NewProjectEvent()
		{
			super(EVENT_ID);
		}
	}
}
