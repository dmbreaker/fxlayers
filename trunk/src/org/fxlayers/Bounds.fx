package org.fxlayers;

public class Bounds {
    public var left: Number;
    public var bottom: Number;
    public var right: Number;
    public var top: Number;
    
    public function getWidth() : Number {
        return right-left;
    }
    
    public function getHeight() : Number {
        return top-bottom;
    }
 }