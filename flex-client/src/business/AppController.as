package business
{
	import com.adobe.cairngorm.control.FrontController;
	import business.commands.*;
	import business.events.*;

	public class AppController extends FrontController
	{
		public function AppController()
		{
			super();
			addCommand(GetProjectsEvent.EVENT_ID, GetProjectsCommand);
			addCommand(DeleteProjectEvent.EVENT_ID, DeleteProjectCommand);
			addCommand(NewProjectEvent.EVENT_ID, NewProjectCommand);
			addCommand(SaveProjectEvent.EVENT_ID, SaveProjectCommand);
		}
	}
}
