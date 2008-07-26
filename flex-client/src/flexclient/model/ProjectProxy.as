package flexclient.model
{
    import mx.collections.ArrayCollection;
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;
    import flexclient.model.vo.ProjectVO;
    import flexclient.model.enum.DepartmentsEnum;

    public class ProjectProxy extends Proxy implements IProxy
    {
        public static const NAME:String = 'ProjectProxy';

        public function ProjectProxy()
        {
            super(NAME, new ArrayCollection);
            // generate some test data            
            addItem(new ProjectVO(100,'Improved Cloud Car', DepartmentsEnum.ACCT));
            addItem(new ProjectVO(201,'Flash Speeder Mk V', DepartmentsEnum.SALES));
            addItem(new ProjectVO(300,'Sandcrawler Restoration', DepartmentsEnum.PLANT));
        }

        // Returns data property cast to proper type.
        public function get projects():ArrayCollection
        {
            return data as ArrayCollection;
        }

        // Adds an item to the data.
        public function addItem(item:Object):void
        {
            projects.addItem(item);
        }
                
        // Updates an item in the data.
        public function updateItem(item:Object):void
        {
            var project:ProjectVO = item as ProjectVO;
            for (var i:int = 0; i<projects.length; i++)
            {
                if (projects[i].code == project.code) {
                    projects[i] = project;
                    break;
                }
            }
        }
        
        // Deletes an item in the data.
        public function deleteItem(item:Object):void
        {
            var project:ProjectVO = item as ProjectVO;
            for (var i:int = 0; i<projects.length; i++)
            {
                if (projects[i].code == project.code) {
                    projects.removeItemAt(i);
                    break;
                }
            }
        }
    }
}
