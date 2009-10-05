package org.fxlayers;

public class Pixel {
    public var x: Number;
    public var y: Number;
    
    public function add(dx: Number, dy: Number) {
    	x = x + dx;
    	y = y + dy;
    }
}
