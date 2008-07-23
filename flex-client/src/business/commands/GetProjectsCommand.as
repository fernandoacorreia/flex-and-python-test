package business.commands
{
	import business.Services;	
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;	
	import flash.net.Responder;	
	import model.ModelLocator;

	public class GetProjectsCommand implements ICommand
	{
		private var __model:ModelLocator = ModelLocator.getInstance();
		private var __locator:ServiceLocator = ServiceLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			var service:Services = __locator as Services;
            service.gateway.call("ProjectService.get_all", new Responder(onResults));
		}
		
		public function onResults(result:Array):void {
            __model.projects = result;
        }
	}
}
