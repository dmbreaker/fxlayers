package org.fxlayers;

import javafx.scene.*;
import javafx.scene.layout.*;

import javafx.scene.input.MouseEvent;

public abstract class Layer extends Container {

	protected var map: Map;

	public var maxExtent: Bounds;
	public var tileSize: Size;

	public function moveTo(bounds: Bounds, dragging: Boolean, forceZoomChange: Boolean) {
		var test = null;
	}
	
	public function setMap(map :Map) {
	    this.map = map;
	    maxExtent = map.maxExtent;
	}
	
	public function getResolution() : Number {
	    // TODO: handle zoom level
		return map.resolution;
	}
	
	public function getExtent() : Bounds {
	    return map.calculateBounds();
	}
	
	public function getLonLatFromViewPortPx(viewPortPx: Pixel): LonLat {
        var center = map.getCenter();
        var res  = map.getResolution();

        var delta_x = viewPortPx.x - (map.width / 2);
        var delta_y = viewPortPx.y - (map.height / 2);
                
        var lonlat = LonLat {
        	lon: center.lon + delta_x * res,
        	lat: center.lat - delta_y * res
        }

        //if (this.wrapDateLine) {
        //    lonlat = lonlat.wrapDateLine(this.maxExtent);
        //}

        return lonlat;
    }
    
    public function getViewPortPxFromLonLat(lonlat: LonLat) {

        var resolution = map.getResolution();
        var extent = map.getExtent();
                    
        return Pixel { x: (1/resolution * (lonlat.lon - extent.left)),
                       y : (1/resolution * (extent.top - lonlat.lat))};
    }
    
}