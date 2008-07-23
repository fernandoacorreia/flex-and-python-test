package model
{
	[Bindable]
	public class ModelLocator
	{
		static private var __instance:ModelLocator = null;
		public var projects:Array = new Array();
		public var project:Object;
		
		static public function getInstance():ModelLocator
		{
			if(__instance == null)
			{
				__instance = new ModelLocator();
			}
			return __instance;
		}
	}
}
