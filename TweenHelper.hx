package;

import flash.geom.Point;
import openfl.Assets;

/**
 * ...
 * @author Henry D. Fernández B.
 */
class TweenHelper
{
	/*Taken from: http://gizma.com/easing/#quint1*/
	
	/*t = currentTime
	 * b start value
	 * c change in value
	 * d duration
	 * */
	
	 /*
	  * simple linear tweening - no easing, no acceleration
	  * */
	public static function Linear(time : Float, startValue : Float, endValue : Float, duration : Float) : Float 
	{
		var step : Float;
		
		step = endValue - startValue;
		
		return step * (time/duration) + startValue;
	}
	
	/*
	 * quadratic easing in - accelerating from zero velocity
	 * */
	public static function QuadraticIn(time : Float, startValue : Float, endValue : Float, duration : Float) : Float 
	{
		var step : Float;
		
		step = endValue - startValue;
		
		time /= duration;
		return step * time * time + startValue;
	}
	
	/*
	 * quadratic easing out - decelerating to zero velocity
	 * */
	public static function QuadraticOut(time : Float, startValue : Float, endValue : Float, duration : Float) : Float 
	{
		var step : Float;
		
		step = endValue - startValue;
		
		time /= duration;
		return -step * time * (time-2) + startValue;
	}
	
	/*
	 * quadratic easing in/out - acceleration until halfway, then deceleration
	 * */
	public static function QuadraticInOut(time : Float, startValue : Float, endValue : Float, duration : Float) : Float 
	{
		var step : Float;
		
		step = endValue - startValue;
		
		time /= duration/2;
		
		if (time < 1) 
			return step / 2 * time * time + startValue;
			
		time--;
		return -step / 2 * (time * (time - 2) - 1) + startValue;
	}
	
	/*
	 * cubic easing in - accelerating from zero velocity
	 * */
	public static function CubicIn(time : Float, startValue : Float, endValue : Float, duration : Float) : Float 
	{
		var step : Float;
		
		step = endValue - startValue;
		
		time /= duration;
		
		return step*time*time*time + startValue;
	}
	
	/*
	 * cubic easing out - decelerating to zero velocity
	 * */
	public static function CubicOut(time : Float, startValue : Float, endValue : Float, duration : Float) : Float 
	{
		var step : Float;
		
		step = endValue - startValue;
		time /= duration;
		time--;
		return step*(time*time*time + 1) + startValue;
	}
	
	/*
	 * cubic easing in/out - acceleration until halfway, then deceleration
	 * */
	public static function CubicInOut(time : Float, startValue : Float, endValue : Float, duration : Float) : Float 
	{
		var step : Float;
		
		step = endValue - startValue;
		time /= duration/2;
		if (time < 1) 
			return step/2*time*time*time + startValue;
		time -= 2;
		return step/2*(time*time*time + 2) + startValue;
	}
}