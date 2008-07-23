package business
{
	import com.adobe.cairngorm.business.ServiceLocator;	
	import flash.net.NetConnection;

	public class Services extends ServiceLocator
	{
		public var gateway:NetConnection;
		
		public function Services()
		{
			super();
            gateway = new NetConnection();
            gateway.connect("http://localhost:8080/");
		}
	}
}
