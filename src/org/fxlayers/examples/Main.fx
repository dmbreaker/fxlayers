package org.fxlayers.examples;

import javafx.scene.*;

import org.fxlayers.*;
import org.fxlayers.control.*;

var scene: Scene;

var map: Map = Map{};

javafx.stage.Stage {
    title : "Test"
    visible: true
    scene: scene = javafx.scene.Scene {
        width: 800
        height: 600
        content: [ map ]
    }
}

def imageLayer = org.fxlayers.layer.Image { 
	url: "http://earthtrends.wri.org/images/maps/4_m_citylights_lg.gif"
	extent: Bounds { 
		left: -180, 
		bottom: -88.759, 
		right: 180, 
		top: 88.759
	}
}

map.addLayer(imageLayer);
map.addControl(MousePosition{});

map.zoomToMaxExtent();
