package flash.external;

import flash.Lib;


class ExternalInterface {
	
	
	public static var available (get, null):Bool;
	public static var marshallExceptions:Bool;
	public static var objectID:String;
	
	private static var callbacks = new Map<String, Dynamic> ();
	
	
	public static function addCallback (functionName:String, closure:Dynamic):Void {
		
		if (!callbacks.exists (functionName)) {
			
			nme_external_interface_add_callback (functionName, handler);
			
		}
		
		callbacks.set (functionName, closure);
		
	}
	
	
	public static function call (functionName:String, ?p1:Dynamic, ?p2:Dynamic, ?p3:Dynamic, ?p4:Dynamic, ?p5:Dynamic):Dynamic {
		
		var params = new Array<Dynamic>();
		
		if (p1 != null) params.push (p1);
		if (p2 != null) params.push (p2);
		if (p3 != null) params.push (p3);
		if (p4 != null) params.push (p4);
		if (p5 != null) params.push (p5);
		
		return nme_external_interface_call (functionName, params);
		
	}
	
	
	private static function handler (functionName:String, params:Array<String>):String {
		
		if (callbacks.exists (functionName)) {
			
			var handler = callbacks.get (functionName);
			return Reflect.callMethod (handler, handler, params);
			
		}
		
		return null;
		
	}
	
	
	public static function registerCallbacks ():Void {
		
		nme_external_interface_register_callbacks ();
		
	}
	
	
	
	
	// Getters & Setters
	
	
	
	
	private static function get_available ():Bool {
		
		return nme_external_interface_available ();
		
	}
	
	
	
	
	// Native Methods
	
	
	
	
	private static var nme_external_interface_add_callback = Lib.load ("nme", "nme_external_interface_add_callback", 2);
	private static var nme_external_interface_available = Lib.load ("nme", "nme_external_interface_available", 0);
	private static var nme_external_interface_call = Lib.load ("nme", "nme_external_interface_call", 2);
	private static var nme_external_interface_register_callbacks = Lib.load ("nme", "nme_external_interface_register_callbacks", 0);
	
	
}