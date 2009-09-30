package org.fxlayers;

import javafx.scene.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.scene.layout.*;

import javafx.scene.input.MouseEvent;

public class Map extends CustomNode  {
	public var center: LonLat = null;
	public var maxResolution: Number = 1.40625;
	public var resolution: Number;
	public var zoom: Number = 0;
	public var projection: String = "EPSG:4326";
	public var maxExtent: Bounds = Bounds { left: -180, bottom: -90, right:180, top:90 };
	
	public def size = Size { w: bind layoutBounds.width, h: bind layoutBounds.height};
	
	var baseLayer: Layer;
	
	var layersContainer =  Container { };
	
	public function addLayer(layer: Layer) {
	    insert layer into layersContainer.content;
	    
	    baseLayer = layer;
	}
	
	public function getSize() : Size {
		return size;
	}
	
	public function getCenter() : LonLat {
		return center;
	}
	
	public function getResolution() : Number {
		return baseLayer.getResolution()
	}
	
	public function getExtent() : Bounds {
	    return baseLayer.getExtent();
	}
	
	public function moveTo(lonlat: LonLat, zoom : Integer, dragging: Boolean, forceZoomChange: Boolean) {
		
		var zoomChanged = forceZoomChange;
		var bounds = getExtent();
		    
		baseLayer.moveTo(bounds, dragging, zoomChanged);
	}

	public function setCenter(lonlat: LonLat, zoom : Integer, dragging: Boolean, forceZoomChange: Boolean) {
		moveTo(lonlat, zoom, dragging, forceZoomChange);
	}
	
	public function calculateBounds(): Bounds {
        var size = this.getSize();
        var w_deg = size.w * resolution;
        var h_deg = size.h * resolution;

        return Bounds {left: this.center.lon - w_deg / 2,
                       bottom: this.center.lat - h_deg / 2,
                       right: this.center.lon + w_deg / 2,
    	               top: this.center.lat + h_deg / 2};
    }
	
	public function getLonLatFromViewPortPx(viewPortPx: Pixel): LonLat {
        return baseLayer.getLonLatFromViewPortPx(viewPortPx);
    }
	
	public function getViewPortPxFromLayerPx(layerPx: Pixel) : Pixel {
        return Pixel {x: layerPx.x+layersContainer.layoutX, y: layerPx.y+layersContainer.layoutY};
    }
	
	public function getLonLatFromLayerPx(px: Pixel): LonLat {
       return getLonLatFromViewPortPx(getViewPortPxFromLayerPx(px));         
    }
    
    public function getLayerPxFromViewPortPx(viewPortPx: Pixel) {
        return Pixel {x: layersContainer.layoutX-viewPortPx.x, y: layersContainer.layoutY- viewPortPx.y};
    }
    
    public function getViewPortPxFromLonLat(lonlat: LonLat) {
        return baseLayer.getViewPortPxFromLonLat(lonlat);
    }
    
    public function getPixelFromLonLat(lonlat: LonLat) {
        return getViewPortPxFromLonLat(lonlat);
    }
    
    public function getLayerPxFromLonLat(lonlat: LonLat) {
       return getLayerPxFromViewPortPx(getPixelFromLonLat(lonlat));         
    }
	
	override function create():Node {
	    
	    resolution = maxResolution;
	    
	    // TODO: will currently never get correct size (bind will stack overflow)
	    var background = Rectangle {
	    	width: bind layoutBounds.width,
            height: bind layoutBounds.height-1,
            fill:Color.RED
        }
        
        // TODO: the map should be bound to its container size ..
        
        return Group { content: [/*background,*/ layersContainer]}
    }
    
}


