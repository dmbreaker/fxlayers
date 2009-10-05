package org.fxlayers.layer;

import org.fxlayers.Bounds;
import org.fxlayers.Size;
import org.fxlayers.LonLat;
import org.fxlayers.Layer;

import javafx.scene.*;
import javafx.scene.image.*;

import javafx.scene.input.MouseEvent;

public class Image extends Layer {
    public var url: String;
	public var extent: Bounds;
	
	var firstRender: Boolean = true;

	def image = javafx.scene.image.Image {
		url: url
	}
	
	def imageView = ImageView {
        image: bind image
    }

	override function doLayout() {
	    
    }
    
    override public function moveTo(bounds: Bounds, dragging: Boolean, forceZoomChange: Boolean) {
	    setTileSize();

    	var ul = LonLat {lon: extent.left, lat: extent.top };
    	var ulPx = map.getLayerPxFromLonLat(ul);

		// TODO: break out into tile logic
    	imageView.x = ulPx.x;
    	imageView.y = ulPx.y;
    	
    	imageView.fitWidth = tileSize.w;
    	imageView.fitHeight = tileSize.h;
    	
    	imageView.visible = true;
    	
    	if (firstRender) {
            insert imageView into content;
        	firstRender = false
        }
	}
	
	public function setTileSize() {
        var tileWidth = extent.getWidth() / map.getResolution();
        var tileHeight = extent.getHeight() / map.getResolution();
        
        tileSize = Size {
        	w: tileWidth
        	h: tileHeight
        }
    }	
}

