package lime.utils;


import haxe.io.Bytes;
import haxe.io.Error;

@:forward(buffer, byteLength, byteOffset)


abstract Float64Array(ArrayBufferView) from ArrayBufferView to ArrayBufferView {
	
	
	public static inline var BYTES_PER_ELEMENT = 8;
	
	public var length (get, never):Int;
	public var name (get, never):String;
	
	
	public function new #if !java <T> #end (bufferOrArray:#if !java T #else Dynamic #end, start:Int = 0, length:Null<Int> = null) {
		
		#if (openfl && neko && !lime_legacy)
		if (Std.is (bufferOrArray, openfl.Vector.VectorData)) {
			
			var vector:openfl.Vector<Float> = cast bufferOrArray;
			var floats:Array<Float> = vector;
			
			this = fromArray (floats);
			
		} else
		#end
		
		if (Std.is (bufferOrArray, Int)) {
			
			var elements:Int = cast bufferOrArray;
			this = new ArrayBufferView (elements * BYTES_PER_ELEMENT);
			
		} else if (Std.is (bufferOrArray, Array)) {
			
			var floats:Array<Float> = cast bufferOrArray;
			this = fromArray (floats);
			
		} else {
			
			this = cast bufferOrArray;
			
		}
		
	}
	
	
	//public inline function new (elements:Int) {
		//
		//this = new ArrayBufferView (elements * BYTES_PER_ELEMENT);
		//
	//}
	
	
	public inline function set (typedArray:ArrayBufferView, offset:Int = 0):Void {
		
		this.buffer.blit (offset, typedArray.buffer, 0, typedArray.byteLength);
		
	}
	
	
	public inline function subarray (?begin:Int, ?end:Int):Float64Array {
		
		return this.subarray (begin == null ? null : begin << 3, end == null ? null : end << 3);
		
	}
	
	
	public static function fromArray (a:Array<Float>, pos:Int = 0, ?length:Int):Float64Array {
		
		if (length == null) length = a.length - pos;
		if (pos < 0 || length < 0 || pos + length > a.length) throw Error.OutsideBounds;
		
		var i = new Float64Array (a.length);
		
		for (idx in 0...length)
			i[idx] = a[idx + pos];
		
		return i;
		
	}
	
	
	public static function fromBytes (bytes:Bytes, bytePos:Int = 0, ?length:Int):Float64Array {
		
		return ArrayBufferView.fromBytes (bytes, bytePos, (length == null ? (bytes.length - bytePos) >> 3 : length) << 3);
		
	}
	
	
	@:noCompletion @:arrayAccess public inline function __get (index:Int):Float {
		
		return this.buffer.getFloat ((index << 3) + this.byteOffset);
		
	}
	
	
	@:noCompletion @:arrayAccess public inline function __set (index:Int, value:Float):Float {
		
		if (index >= 0 && index < length) {
			
			this.buffer.setFloat ((index << 3) + this.byteOffset, value);
			return value;
			
		}
		
		return 0;
		
	}
	
	
	
	
	// Get & Set Methods
	
	
	
	
	private inline function get_length ():Int {
		
		return this.byteLength >> 3;
		
	}
	
	
	private inline function get_name ():String {
		
		return "Float64Array";
		
	}
	
	
}