package org.fxlayers.layer;

import org.fxlayers.Bounds;
import org.fxlayers.Size;
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
	   
        return Group { content: [ imageView ] }
    }
    
    override public function moveTo(bounds: Bounds, dragging: Boolean, forceZoomChange: Boolean) {
    	var ulPx = map.getLayerPxFromLonLat(LonLat {lon: extent.left, lat: extent.top });
    	
    	imageView.fitWidth = map.getSize().w;
    	imageView.fitHeight = map.getSize().h;
    	imageView.visible = true;
	}
	
	public function setTileSize(): Size {
        var tileWidth = extent.getWidth() / this.map.getResolution();
        var tileHeight = extent.getHeight() / this.map.getResolution();
        this.tileSize = Size {w: tileWidth, h:tileHeight};
    }
	
	public function test() {
	    // TODO: map is same size as layers :(
    	imageView.fitWidth = map.getSize().w;
    	imageView.fitHeight = map.getSize().h;
    	imageView.visible = true;
	}
	
}

