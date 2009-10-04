package org.fxlayers;

import javafx.util.*;
import javafx.scene.*;
import javafx.scene.layout.*;

import javafx.scene.input.MouseEvent;

public abstract class Layer extends Container {

	protected var map: Map;

	public var maxExtent: Bounds;
	public var tileSize: Size;

	public function moveTo(bounds: Bounds, dragging: Boolean, forceZoomChange: Boolean) {
		var test = null
	}
	
	public function setMap(map: Map) {
	    this.map = map;
	    
	    maxExtent = map.maxExtent
	}
	
	public function getResolution() : Number {
	    // TODO: handle zoom level
		map.resolution
	}
	
	public function getExtent() : Bounds {
	    map.calculateBounds()
	}
	
	public function getZoomForExtent(extent: Bounds, closest: Boolean) {
        var viewSize = map.getSize();
        
        var idealResolution = Math.max(extent.getWidth() / viewSize.w, extent.getHeight() / viewSize.h);

        getZoomForResolution(idealResolution, closest)
    }
    
    public function onMapResize() {
        width = map.width;
        height = map.height;
    }
    
    public function getZoomForResolution(resolution: Number, closest: Boolean) {
        // TODO: implement for zoomlevels...
        
        var zoomlevel: Integer = 0
    }
	
	public function getLonLatFromViewPortPx(viewPortPx: Pixel): LonLat {
        var center: LonLat = map.getCenter();
        var res: Number = map.getResolution();

        var delta_x: Number = viewPortPx.x - (map.width / 2);
        var delta_y: Number = viewPortPx.y - (map.height / 2);
        
        var lonlat = LonLat {
        	lon: center.lon + delta_x * res
        	lat: center.lat - delta_y * res
        }

        //if (this.wrapDateLine) {
        //    lonlat = lonlat.wrapDateLine(this.maxExtent);
        //}
    }
    
    public function getViewPortPxFromLonLat(lonlat: LonLat) {

        var resolution: Number = map.getResolution();
        var extent: Bounds = map.getExtent();
                   
        var pixel: Pixel = Pixel {
        	x: (1/resolution * (lonlat.lon - extent.left))
        	y: (1/resolution * (extent.top - lonlat.lat))
        }
    }
    
}