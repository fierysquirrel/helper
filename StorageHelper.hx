package;

import openfl.Assets;

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
}