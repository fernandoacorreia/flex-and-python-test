package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;	
	import model.ModelLocator;
	
	public class NewProjectCommand implements ICommand
	{
		private var __model:ModelLocator = ModelLocator.getInstance();

		public function execute(event:CairngormEvent):void
		{
        	__model.project = new Object();
        	__model.project.code = null;
        	__model.project.name = null;
        	__model.project.created_at = null;
        	__model.project.modified_at = null;
        	__model.project._key = null;
		}
	}
}