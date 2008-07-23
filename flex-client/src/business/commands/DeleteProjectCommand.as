package business.commands
{
	import business.Services;
	import business.events.DeleteProjectEvent;	
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.net.Responder;
	
	import model.ModelLocator;

	public class DeleteProjectCommand implements ICommand
	{
		private var __model:ModelLocator = ModelLocator.getInstance();
		private var __locator:ServiceLocator = ServiceLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			var project:Object = (event as DeleteProjectEvent).project;
			var service:Services = __locator as Services;
            service.gateway.call("ProjectService.delete", new Responder(onResults), project);
		}
		
		public function onResults(result:Object):void {
        }
	}
}
