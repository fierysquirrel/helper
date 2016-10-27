package;

import flash.geom.Point;
import openfl.Assets;

/**
 * ...
 * @author Henry D. Fernández B.
 */
class MathHelper
{
	//Set of values to generate unique ids
	private static var UID_CHARS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	
	//Max hexadecimal value
	private static var MAX_HEX = 255;
	
	//Constant to represent ONE second in milliseconds.
	private static var MILLISECONDS : Int = 1000;
	
	//Frames Per Second
	private static var FPS : Float = 60;
	
	//Converstion rate for degrees <-> rad
	private static var DEGREE_RAD_CONVERSION : Float = (Math.PI / 180);
	
	//Time step according to the FPS and MIlliseconds
	private static var TIME_STEP : Float = (FPS / MILLISECONDS);
	
	public static function CreateID(?size : Int) : String 
	{
		if (size == null) 
			size = 32;
			
		var nchars = UID_CHARS.length; 
		var uid = new StringBuf(); 
		
		for (i in 0 ... size)
			uid.add(UID_CHARS.charAt( Std.int(Math.random() * nchars) )); 
		
		return uid.toString(); 
	}
	
	/*
	* Converts a number to a Character
	* @param number between 0 and UID_CHARS.length
	* @return Character from 0 to z
	*/
	public static function FromNumberToChar(number : Int) : String 
	{
		if (number < 0 || number > UID_CHARS.length)
			throw "Error: number between 0 and " + UID_CHARS.length;
			
		return UID_CHARS.charAt(number); 
	}
	
   /*
	* Return object with rgb triplet from hex float
	* <pre class="code haxe">
	* var rgb = Color.toRGB(Color.RED);
	* // outputs 0
	* trace(rgb.r-255);
	* </pre>
	* @param input color
	* @return Dynamic object with r,g,b fields
	*/
	public static inline function HexToRGB(color:Int) : Array<Float> 
	{
		
		var r : Int = (color >> 16) & 0xFF ;
		var g : Int = (color >> 8) & 0xFF ;
		var b : Int = color & 0xFF ;
		
		return [r/MAX_HEX,g/MAX_HEX, b/MAX_HEX];
	}
	
	public static inline function CalculateReflect(vector : Point, normal : Point) : Point
	{
		var relNv : Float;
		var reflect : Point;
		
		relNv = vector.x * normal.x + vector.y * normal.y;
		reflect = new Point();
		reflect.x = (vector.x - (2 * relNv * normal.x));
		reflect.y = (vector.y - (2 * relNv * normal.y));
					
		
		return reflect;
	}
	
	public static function Normalize(vector : Point) : Point
	{
		var mod : Float;
		var normalized : Point;
		
		mod = Math.sqrt(Math.pow(vector.x, 2) + Math.pow(vector.y, 2));
		
		if(mod > 0)
			normalized = new Point(vector.x / mod, vector.y / mod);
		else
			normalized = vector;
		
		
		return normalized;
	}
	
	/// <summary>
	/// Get the direction to aim the initial point to final point.
	/// </summary>
	/// <param name="initialPoint">Initial point.</param>
	/// <param name="finalPoint">Final point.</param>
	/// <returns>An unitary vector pointing to the final point.</returns>
	public static function Aim(initialPoint : Point,finalPoint : Point) : Point
	{
		var direction, aim : Point;
		var dirLength : Float;
		
		direction = new Point();
		direction.x = finalPoint.x - initialPoint.x;
		direction.y = finalPoint.y - initialPoint.y;

		dirLength = Math.sqrt(Math.pow(direction.x, 2) + Math.pow(direction.y, 2));
		
		if (dirLength == 0)
			aim = Normalize(finalPoint);
		else
			aim = Normalize(direction);

		return aim;
	}
	
	/// <summary>
	/// Get the direction to aim the initial point to final point.
	/// </summary>
	/// <param name="initialPoint">Initial point.</param>
	/// <param name="finalPoint">Final point.</param>
	/// <returns>An unitary vector pointing to the final point.</returns>
	public static function RotateVector(angle : Float,vector : Point) : Point
	{
		var x , y : Float;
		
		x = vector.x * Math.cos(angle) - vector.y * Math.sin(angle);
		y = vector.y * Math.cos(angle) - vector.x * Math.sin(angle);

		return new Point(x,y);
	}
	
	public static function ClampValue(value : Int, min : Int,max : Int) : Int
	{
		var clampVal : Int;
		
		clampVal = value;
		
		if (value > max)
			clampVal = max;
		else if (value < min)
			clampVal = min;
		
		return clampVal;
	}
	
	public static function Clamp(vector : Point, max : Point) : Point
	{
		var clampVec : Point;
		
		clampVec = new Point(vector.x,vector.y);
		
		if (vector.x > Math.abs(max.x))
			clampVec.x = Math.abs(max.x);
		else if (vector.x < -Math.abs(max.x))
			clampVec.x = -Math.abs(max.x);
			
		if (vector.y > Math.abs(max.y))
			clampVec.y = Math.abs(max.y);
		else if (vector.y < -Math.abs(max.y))
			clampVec.y = -Math.abs(max.y);

		return clampVec;
	}
	
	public static function CrossProduct(vector1 : Point,vector2 : Point) : Float
    {
		var cross : Float;

		cross = vector1.x * vector2.y - vector1.y * vector2.x;

		return cross;
    }
	
	public static function DotProduct(vector1 : Point,vector2 : Point) : Float
    {
		var dot : Float;

		dot = vector1.x * vector2.x + vector1.y * vector2.y;

		return dot;
    }
	
	public static function Module(vector : Point) : Float
    {
		var module : Float;

		module = Math.sqrt(Math.pow(vector.x, 2) + Math.pow(vector.y, 2));

		return module;
    }
	
	public static function CalculateAngle(vector1 : Point, vector2 : Point) : Float
    {
		var angle : Float;
		var mod : Float;

		mod = Module(vector1) * Module(vector2);
		if(mod > 0)
			angle = Math.acos(DotProduct(vector1, vector2) / mod);
		else
			angle = 0;
		
		return angle;
    }
	
	public static function ConvertSecToMillisec(val : Float) : Float
    {
		return MILLISECONDS * val;
    }
	
	public static function ConvertMillisecToSec(val : Float) : Float
    {
		return val / MILLISECONDS;
    }
	
	public static function ConvertRadToDeg(val : Float) : Float
    {
		return (val * 180) / Math.PI;
    }
	
	public static function ConvertDegToRad(val : Float) : Float
    {
		return (val * Math.PI) / 180;
    }
	
	public static function TransformPoint(point : Point, pivot : Point, theta : Float) : Point
	{
		var newPoint : Point;
		newPoint = new Point();
		
		newPoint.x = pivot.x + (point.x - pivot.x) * Math.cos(theta) - (point.y - pivot.y) * Math.sin(theta);
		newPoint.y = pivot.y + (point.x - pivot.x) * Math.sin(theta) + (point.y - pivot.y) * Math.cos(theta);
		
		return newPoint;
	}
	
	public static function PointInsideRectangle(point : Point,rectPos : Point,rectWidth : Float,rectHeight : Float) : Bool
	{
		var xCond, yCond : Bool;
		
		xCond = point.x <= rectPos.x + rectWidth/2 && point.x >= rectPos.x - rectWidth/2;
		yCond = point.y <= rectPos.y + rectHeight/2 && point.y >= rectPos.y - rectHeight/2;
		
		return xCond && yCond;
	}
	
	public static function PointOutsideRectangle(point : Point,rectPos : Point,rectWidth : Float,rectHeight : Float) : Bool
	{
		var xCond, yCond : Bool;
		
		xCond = point.x > rectPos.x + rectWidth/2 || point.x < rectPos.x - rectWidth/2;
		yCond = point.y > rectPos.y + rectHeight/2 || point.y < rectPos.y - rectHeight/2;
		
		return xCond || yCond;
	}
	
	public static function PointInsideCircle(point : Point, circlePoint : Point, radius : Float) : Bool
	{
		return ((point.x - circlePoint.x) * (point.x - circlePoint.x)) + ((point.y - circlePoint.y) * (point.y - circlePoint.y)) < radius * radius;
	}
	
	public static function F2T(delta : Float, value : Float) : Float
	{
		return (value * delta) * TIME_STEP;
	}
	
	public static function P2T(delta : Float, value : Point) : Point
	{
		return new Point((value.x * delta) * TIME_STEP,(value.y * delta) * TIME_STEP);
	}
}