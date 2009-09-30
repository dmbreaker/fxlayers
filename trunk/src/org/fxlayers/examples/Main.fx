package org.fxlayers.examples;

import org.fxlayers.*;

def map = Map{};

javafx.stage.Stage {
    title : "Hello World"
    width: 400
    height: 400
    visible: true
    scene: javafx.scene.Scene {
        content: [ map ]
    }
}

def imageLayer = org.fxlayers.layer.Image{};

map.addLayer(imageLayer);

map.setCenter(LonLat{lon: 0, lat: 0}, 0, false, false);

imageLayer.test();
