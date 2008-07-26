package flexclient.model
{
	import flash.net.NetConnection;
	import flash.net.Responder;	
	import flexclient.model.vo.ProjectVO;	
	import mx.collections.ArrayCollection;	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import flexclient.model.enum.DepartmentsEnum;

    public class ProjectProxy extends Proxy implements IProxy
    {
        public static const NAME:String = 'ProjectProxy';
        
        public function ProjectProxy()
        {
            super(NAME, new ArrayCollection);
            Gateway().call("ProjectService.get_all", new Responder(onGetAllResult));
        }
        
        // Returns data property cast to proper type.
        public function get projects():ArrayCollection
        {
            return data as ArrayCollection;
        }

        private function Gateway():NetConnection
        {
            var gateway:NetConnection;
            gateway = new NetConnection();
            gateway.connect("http://localhost:8080/");
            return gateway;
        }

        private function onGetAllResult(result:Array):void
        {
            for (var i:int = 0; i < result.length; i++)
            {
            	projects.addItem(new ProjectVO(result[i]))
            }
        }

        // Adds an item to the data.
        public function addItem(item:Object):void
        {
        	Gateway().call("ProjectService.save", new Responder(onAddItemResult), item);
        }
        
        private function onAddItemResult(result:Object):void
        {
            projects.addItem(new ProjectVO(result));
        }
                
        // Updates an item in the data.
        public function updateItem(item:Object):void
        {
        	Gateway().call("ProjectService.save", new Responder(onUpdateItemResult), item);
        }
        
        private function onUpdateItemResult(result:Object):void
        {
            for (var i:int = 0; i < projects.length; i++)
            {
                if (projects[i]._key == result._key)
                {
                    projects[i] = new ProjectVO(result);
                    break;
                }
            }
        }
                
        // Deletes an item in the data.
        public function deleteItem(item:Object):void
        {
            var project:ProjectVO = item as ProjectVO;
        	Gateway().call("ProjectService.delete", null, project);
            for (var i:int = 0; i < projects.length; i++)
            {
                if (projects[i]._key == project._key) {
                    projects.removeItemAt(i);
                    break;
                }
            }
        }
    }
}
