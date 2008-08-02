package flexclient.model
{
	import flash.net.NetConnection;
	import flash.net.Responder;	
	import flexclient.model.Project;	
	import mx.collections.ArrayCollection;	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import flexclient.model.enum.DepartmentsEnum;

    public class ProjectsProxy extends Proxy
    {
        public static const NAME:String = 'ProjectsProxy';

        public function ProjectsProxy()
        {
            super(NAME, new ArrayCollection);
            Gateway().call("ProjectsService.get_all", new Responder(onGetAllResult));
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
            	projects.addItem(new Project(result[i]))
            }
        }

        // Adds an item to the data.
        public function addItem(item:Object):void
        {
        	Gateway().call("ProjectsService.save", new Responder(onAddItemResult), item);
        }

        private function onAddItemResult(result:Object):void
        {
            projects.addItem(new Project(result));
        }

        // Updates an item in the data.
        public function updateItem(item:Object):void
        {
        	Gateway().call("ProjectsService.save", new Responder(onUpdateItemResult), item);
        }

        private function onUpdateItemResult(result:Object):void
        {
            for (var i:int = 0; i < projects.length; i++)
            {
                if (projects[i]._key == result._key)
                {
                    projects[i] = new Project(result);
                    break;
                }
            }
        }

        // Deletes an item in the data.
        public function deleteItem(item:Object):void
        {
            var project:Project = item as Project;
        	Gateway().call("ProjectsService.delete", null, project);
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
