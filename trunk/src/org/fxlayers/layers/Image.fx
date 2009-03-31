package org.fxlayers.layers;

import org.fxlayers.Layer;

import javafx.scene.*;
import javafx.scene.image.*;

import javafx.scene.input.MouseEvent;

public class Image extends Layer {
	var x:Number = 0;
	var y:Number = 0;
	
	var previousDrag = 0;

	var image = javafx.scene.image.Image {
		url: "http://www.google.com/logos/Logo_25wht.gif"
	    //url: "{__DIR__}/test/data/myotuva.png"
	};
	
	
	override function create():Node {
        return ImageView {
	        x: bind x
	        y: bind y
            image: image
        }
    }
    
    override public function moveTo(mouseEvent : MouseEvent) {
    	if (mouseEvent.dragX>0) {
    		
    		x = x+(mouseEvent.dragX-previousDrag);
    		previousDrag = mouseEvent.dragX;
    	}
    	else {
    		previousDrag = 0;
    	}
    
    	
	}
    
}

