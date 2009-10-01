package org.fxlayers.examples;

import javafx.scene.*;

import org.fxlayers.*;

var scene: Scene;

var map: Map;

javafx.stage.Stage {
    title : "Test"
    visible: true
    scene: scene = javafx.scene.Scene {
        width: 400
        height: 400
        content: [ map = Map{} ]
    }
}

def imageLayer = org.fxlayers.layer.Image{ extent: Bounds { left: -180, bottom: -90, right:180, top:90 } };

map.addLayer(imageLayer);

map.setCenter(LonLat{lon: 0, lat: 0}, 0, false, false);
