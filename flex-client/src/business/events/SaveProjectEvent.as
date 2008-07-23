package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;	
	import valueObjects.Project;

	public class SaveProjectEvent extends CairngormEvent
	{
		static public var EVENT_ID:String = "SaveProjectEvent";
		public var project:Project = null;
		
		public function SaveProjectEvent(project:Project)
		{
			super(EVENT_ID);
			this.project = project;
		}
	}
}
