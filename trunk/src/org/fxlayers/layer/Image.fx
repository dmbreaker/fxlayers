package org.fxlayers.layer;

import org.fxlayers.Bounds;
import org.fxlayers.Size;
import org.fxlayers.LonLat;
import org.fxlayers.Layer;

import javafx.scene.*;
import javafx.scene.image.*;

import javafx.scene.input.MouseEvent;

public class Image extends Layer {
	public var extent: Bounds;
	
	var firstRender: Boolean = true;

	var image = javafx.scene.image.Image {
		url: "http://www.google.com/logos/Logo_25wht.gif"
	}
	
	def imageView = ImageView {
        image: bind image
    }

	override function doLayout() {
	    
    }
    
    override public function moveTo(bounds: Bounds, dragging: Boolean, forceZoomChange: Boolean) {
	    setTileSize();
    	
    	// TODO: fix this calc..
    	var ulPx = map.getLayerPxFromLonLat(LonLat {lon: extent.left, lat: extent.top });
    	ulPx.x = 0;
    	ulPx.y = 0;
    	
    	imageView.x = ulPx.x;
    	imageView.y = ulPx.y;
    	
    	imageView.fitWidth = tileSize.w;
    	imageView.fitHeight = tileSize.h;
    	
    	imageView.visible = true;
    	
    	if (firstRender) {
            insert imageView into content;
        	firstRender = false;
        }
        
        return null;
	}
	
	public function setTileSize(): Size {
	    // TODO: fix this calc...
        var tileWidth = extent.getWidth() / map.getResolution();
        var tileHeight = extent.getHeight() / map.getResolution();
        tileSize = Size {w: tileWidth, h:tileHeight};
    }	
}

