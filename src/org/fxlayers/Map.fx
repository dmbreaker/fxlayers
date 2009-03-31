package org.fxlayers;

import javafx.scene.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;

import javafx.scene.input.MouseEvent;

public class Map extends CustomNode  {
	var layersGroup =  Group {

    };
	
	public var layers = bind layersGroup.content with inverse;
	
	override function create():Node {

    	this.onMouseDragged = function(mouseEvent : MouseEvent) {
	    	
	    	for (layer in layers) {
	    		(layer as Layer).moveTo(mouseEvent);

	    	}

	    };
        
        return layersGroup
    }
    
    
    
}


