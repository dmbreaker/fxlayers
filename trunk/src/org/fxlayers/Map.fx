package org.fxlayers;

import javafx.scene.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.scene.layout.*;
import javafx.scene.input.*;

import javafx.scene.input.MouseEvent;

public class Map extends Container  {
    override var width = bind scene.width on replace { mapResize(); };
    override var height = bind scene.height on replace { mapResize(); };
    
	public var center: LonLat = null;
	public var maxResolution: Number = 1.40625;
	public var resolution: Number;
	public var zoom: Number = 0;
	public var projection: String = "EPSG:4326";
	public var maxExtent: Bounds = Bounds {
		left: -180
		bottom: -90
		right: 180
		top: 90
	}
	public var px: Number;
	public var py: Number;
	override var onMouseMoved = function(e:MouseEvent) { 
	    // TODO: hmm..
		px = e.x;
		py = e.y;
	}
	
	var dx: Number = 0;
	var dy: Number = 0;
	
	override var onMouseDragged = function(e:MouseEvent) {
		// TODO: move into pan control
		var centerPx: Pixel = getViewPortPxFromLonLat(getCenter());
		centerPx.add(-e.dragX+dx, -e.dragY+dy);
		var newCenterLonLat = getLonLatFromViewPortPx(centerPx);
		setCenter(newCenterLonLat, 0, false, false);
		
		dx = e.dragX;
		dy = e.dragY;
	}
	
	override var onMouseReleased = function(e:MouseEvent) {
		dx = 0;
		dy = 0;
	}
		
	var firstRender: Boolean = true;
	var size: Size = Size { 
		w: bind width
		h: bind height
	}
	var background: Rectangle = Rectangle {
    	width: bind width
        height: bind height
        fill: Color.RED
    }
	var baseLayer: Layer;
	var layersContainer = Container { }
	var controlsContainer = Container { }
	
	public function addLayer(layer: Layer) {
	    layer.setMap(this);
	    
	    insert layer into layersContainer.content;
	    
	    baseLayer = layer
	}
	
	public function addControl(control: Control) {
	    control.setMap(this);
	    
	    insert control into controlsContainer.content;
	}
	
	public function getSize() {
	    size
	}
	
	public function getMaxExtent() { 
        maxExtent
    }
	
	public function getCenter() : LonLat {
		center
	}
	
	public function getResolution() : Number {
		baseLayer.getResolution()
	}
	
	public function getExtent() : Bounds {
	    baseLayer.getExtent()
	}
	
	public function moveTo(lonlat: LonLat, zoom : Integer, dragging: Boolean, forceZoomChange: Boolean) {
		var zoomChanged = forceZoomChange;
		
		resolution = maxResolution;
		
		var bounds = getExtent();
		
		if (firstRender) {
            insert background into content;            
        	insert layersContainer into content;
        	insert controlsContainer into content;
        	
        	firstRender = false;
        }
		    
		baseLayer.moveTo(bounds, dragging, zoomChanged)
	}

	public function setCenter(lonlat: LonLat, zoom : Integer, dragging: Boolean, forceZoomChange: Boolean) {
		center = lonlat;
		moveTo(lonlat, zoom, dragging, forceZoomChange)
	}
	
	public function zoomToMaxExtent() {
        zoomToExtent(maxExtent, false)
    }
    
    public function zoomToExtent(bounds: Bounds, closest: Boolean) {
    	setCenter(center, getZoomForExtent(bounds, closest), false, false)
    }
    
    function getZoomForExtent(bounds: Bounds, closest: Boolean) {
        baseLayer.getZoomForExtent(bounds, closest)
    }
    
    public function getZoomForResolution(resolution: Number, closest: Boolean) {
        baseLayer.getZoomForResolution(resolution, closest)
    }
	
	public function calculateBounds(): Bounds {
        var w_deg = width * resolution;
        var h_deg = height * resolution;

        Bounds {
        	left: this.center.lon - w_deg / 2
            bottom: this.center.lat - h_deg / 2
            right: this.center.lon + w_deg / 2
    	    top: this.center.lat + h_deg / 2
    	}
    }
	
	public function mapResize() {
	    baseLayer.onMapResize()
	}
	
	public function getLonLatFromViewPortPx(viewPortPx: Pixel): LonLat {
        baseLayer.getLonLatFromViewPortPx(viewPortPx)
    }
	
	public function getViewPortPxFromLayerPx(layerPx: Pixel) : Pixel {
        Pixel {
        	x: layerPx.x+layersContainer.layoutX
        	y: layerPx.y+layersContainer.layoutY
        }
    }
	
	public function getLonLatFromLayerPx(px: Pixel): LonLat {
       getLonLatFromViewPortPx(getViewPortPxFromLayerPx(px));         
    }
    
    public function getLayerPxFromViewPortPx(viewPortPx: Pixel) {
        Pixel {
        	x: viewPortPx.x-layersContainer.layoutX
        	y: viewPortPx.y-layersContainer.layoutY
        }
    }
    
    public function getViewPortPxFromLonLat(lonlat: LonLat) {
        baseLayer.getViewPortPxFromLonLat(lonlat)
    }
    
    public function getPixelFromLonLat(lonlat: LonLat) {
        getViewPortPxFromLonLat(lonlat)
    }
    
    public function getLayerPxFromLonLat(lonlat: LonLat) {
       getLayerPxFromViewPortPx(getPixelFromLonLat(lonlat))  
    }
	
	override function doLayout() {
        
    }
    
}
