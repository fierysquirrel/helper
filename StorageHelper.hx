package;

import openfl.Assets;
import openfl.net.SharedObject;
import openfl.net.SharedObjectFlushStatus;

/**
 * ...
 * @author Henry D. Fernández B.
 */
class StorageHelper
{
	public static function LoadXML(path : String) : Xml
	{
		var xml : Xml;
		var str : String;
		
		str = Assets.getText(path);
		xml = Xml.parse(str).firstElement();
		
		return xml;
	}
	
	public static function SaveData(sharedObj : SharedObject) : Dynamic
	{
		// Prepare to save.. with some checks
		#if ( cpp || neko )
			// Android didn't wanted SharedObjectFlushStatus not to be a String
			var flushStatus : SharedObjectFlushStatus = null;
		#else
			// Flash wanted it very much to be a String
			var flushStatus : String = null;
		#end

		try 
		{
			flushStatus = sharedObj.flush() ;// Save the object
		} 
		catch ( e:Dynamic ) 
		{
			trace('couldn\'t write...');
		}
		
		return flushStatus;
	}
}