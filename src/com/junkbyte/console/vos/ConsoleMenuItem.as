/*
*
* Copyright (c) 2008-2011 Lu Aye Oo
*
* @author 		Lu Aye Oo
*
* http://code.google.com/p/flash-console/
* http://junkbyte.com
*
*
* This software is provided 'as-is', without any express or implied
* warranty.  In no event will the authors be held liable for any damages
* arising from the use of this software.
* Permission is granted to anyone to use this software for any purpose,
* including commercial applications, and to alter it and redistribute it
* freely, subject to the following restrictions:
* 1. The origin of this software must not be misrepresented; you must not
* claim that you wrote the original software. If you use this software
* in a product, an acknowledgment in the product documentation would be
* appreciated but is not required.
* 2. Altered source versions must be plainly marked as such, and must not be
* misrepresented as being the original software.
* 3. This notice may not be removed or altered from any source distribution.
*
*/
package com.junkbyte.console.vos {
	import com.junkbyte.console.interfaces.IConsoleMenuItem;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Event(name="change", type="flash.events.Event")]
	public class ConsoleMenuItem extends EventDispatcher implements IConsoleMenuItem{
		
		public var name:String;
		public var callback:Function;
		public var arguments:Array;
		public var tooltip:String;
		public var visible:Boolean;
		public var active:Boolean;
		public var sortPriority:int;
		
		public function ConsoleMenuItem(name : String, cb:Function = null, args:Array = null, tooltip:String = null) : void {
			this.name = name;
			this.callback = cb;
			this.arguments = args;
			this.tooltip = tooltip;
		}
		
		
		public function isVisible():Boolean{
			return visible;
		}
		
		public function getName():String{
			return name;
		}
		
		public function onClick():void{
			if(callback != null)
			{
				callback.apply(this, arguments);
			}
		}
		
		// return true if you want it to be on active state (bold text)
		public function isActive():Boolean{
			return active;
		}
		
		public function getTooltip():String{
			return tooltip;
		}
		
		public function getSortPriority():int{
			return sortPriority;
		}
		
		public function announceChanged():void{
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
}