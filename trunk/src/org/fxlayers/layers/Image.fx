package org.fxlayers.layers;

import org.fxlayers.Bounds;
import org.fxlayers.LonLat;
import org.fxlayers.Layer;

import javafx.scene.*;
import javafx.scene.image.*;

import javafx.scene.input.MouseEvent;

public class Image extends Layer {
	var extent: Bounds;

	var image = javafx.scene.image.Image {
		url: "http://www.google.com/logos/Logo_25wht.gif"
	}
	
	def imageView = ImageView {
        image: bind image
        visible: false
    }

	
	override function create():Node {
		//imageView.fitWidth = 800;
	   
        return  Group { content: [ imageView ] }
    }
    
    override public function moveTo(bounds: Bounds) {
    	//var ulPx = map.getLayerPxFromLonLat(LonLat {lon: extent.left, lat: extent.top });
    	
    	//imageView.fitWidth = map.getSize().w;
    	//imageView.fitHeight = map.getSize().h;
    	imageView.visible = true;
	}
	
	public function test() {
    	imageView.fitWidth = map.getSize().w;
    	imageView.fitHeight = map.getSize().h;
    	imageView.visible = true;
	}
	
}

