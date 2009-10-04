package org.fxlayers.control;

import org.fxlayers.*;
import javafx.scene.*;
import javafx.scene.text.*;
import javafx.scene.paint.*;
import javafx.scene.input.*;

public class MousePosition extends Control {
	
	bound function setText(): String {
		var lonlat: LonLat = map.getLonLatFromLayerPx(Pixel{x: map.px, y: map.py});
		
		var text = "Lon: {lonlat.lon} Lat: {lonlat.lat}";
	}
	
	override public function create(): Node {
		Text {
		    x: 10
		    y: 50
		    stroke: Color.YELLOW
		    font: Font { size: 20}
		    content: bind setText()
		}
	}
}