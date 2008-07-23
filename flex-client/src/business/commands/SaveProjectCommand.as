package business.commands
{
	import business.Services;
	import business.events.SaveProjectEvent;	
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;	
	import flash.net.Responder;	
	import model.ModelLocator;

	public class SaveProjectCommand implements ICommand
	{
		private var __model:ModelLocator = ModelLocator.getInstance();
		private var __locator:ServiceLocator = ServiceLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			var project:Object = (event as SaveProjectEvent).project;
			var service:Services = __locator as Services;
            service.gateway.call("ProjectService.save", new Responder(onResults), project);
		}
		
		public function onResults(result:Object):void {
        }
	}
}
