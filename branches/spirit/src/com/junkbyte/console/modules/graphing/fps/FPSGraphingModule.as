package com.junkbyte.console.modules.graphing.fps
{
	import com.junkbyte.console.core.ModuleTypeMatcher;
	import com.junkbyte.console.events.ConsoleEvent;
	import com.junkbyte.console.interfaces.IMainMenu;
	import com.junkbyte.console.modules.graphing.GraphingGroup;
	import com.junkbyte.console.modules.graphing.GraphingLine;
	import com.junkbyte.console.modules.graphing.GraphingModule;
	import com.junkbyte.console.view.StageModule;
	import com.junkbyte.console.vos.ConsoleMenuItem;
	
	import flash.display.Stage;
	import flash.events.Event;

	public class FPSGraphingModule extends GraphingModule
	{

		protected var stage:Stage;

		private var frames:uint;
		
		protected var menu:ConsoleMenuItem;
		
		private var values:Vector.<Number> = new Vector.<Number>(1);

		public function FPSGraphingModule(startImmediately:Boolean = false)
		{
			
			menu = new ConsoleMenuItem("F", onMenuClick, null, "Frames per second::monitor");
			menu.sortPriority = -10;
			menu.visible = false;
			menu.active = startImmediately;
			
			
			addModuleRegisteryCallback(new ModuleTypeMatcher(StageModule), stageModuleRegistered, stageModuleUnregistered);
			addModuleRegisteryCallback(new ModuleTypeMatcher(IMainMenu), onMainMenuRegistered, onMainMenuUnregistered);
			
			super();
		}

		protected function stageModuleRegistered(module:StageModule):void
		{
			stage = module.stage;
			checkIfDependenciesReady();
		}

		protected function stageModuleUnregistered(module:StageModule):void
		{
			stage = null;
			stop();
		}
		
		protected function onMainMenuRegistered(module:IMainMenu):void
		{
			module.addMenu(menu);
		}
		
		protected function onMainMenuUnregistered(module:IMainMenu):void
		{
			module.removeMenu(menu);
		}
		
		private function onMenuClick():void
		{
			if(menu.active)
			{
				stop();
			}
			else
			{
				start();
			}
		}

		override protected function isDependenciesReady():Boolean
		{
			return stage != null && super.isDependenciesReady();
		}

		override protected function onDependenciesReady():void
		{
			menu.visible = true;
			menu.announceChanged();
			if(menu.active)
			{
				start();
			}
		}

		override protected function createGraphingGroup():GraphingGroup
		{
			var group:FPSGraphingGroup = new FPSGraphingGroup();
			group.fixedMax = stage.frameRate;
			return group;
		}
		
		override protected function onUpdateData(msDelta:uint):void
		{
			if(console.paused)
			{
				return;
			}
			frames++;
			timeSinceUpdate += msDelta;
			
			while (timeSinceUpdate >= _group.updateFrequencyMS)
			{
				pushValues();
				timeSinceUpdate = timeSinceUpdate - _group.updateFrequencyMS;
			}
		}

		override protected function getValues():Vector.<Number>
		{
			var fps:uint = frames * (1000 / group.updateFrequencyMS);
			frames = 0;
			if (fps > group.fixedMax)
			{
				fps = group.fixedMax;
			}
			values[0] = fps;
			return values;
		}
		
		override protected function start():void
		{
			menu.active = true;
			menu.announceChanged();
			super.start();
		}
		
		override protected function onGroupClose(event:Event):void
		{
			menu.active = false;
			menu.announceChanged();
			
			super.onGroupClose(event);
		}
	}
}
