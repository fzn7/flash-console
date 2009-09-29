/*
* 
* Copyright (c) 2008 Atticmedia
* 
* @author 		Lu Aye Oo
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
* 
*/
package com.atticmedia.console.core {
	import flash.utils.Dictionary;
	
	public dynamic class WeakRef{
		private var _dic:Dictionary;
		
		public function WeakRef(obj:*, strong:Boolean = false) {
			_dic = new Dictionary(!strong);
			_dic[obj] = null;
		}
		public function get reference():*{
			//there should be only 1 key in it anyway
			for(var X:* in _dic){
				return X;
			}
			return null;
		}
	}
}