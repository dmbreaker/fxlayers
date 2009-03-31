package org.fxlayers.examples;

def map = org.fxlayers.Map{};

javafx.stage.Stage {
    title : "Hello World"
    width: 400
    height: 400
    visible: true
    scene: javafx.scene.Scene {
        content: [ map ]
    }
}

def imageLayer = org.fxlayers.layers.Image{};

insert imageLayer into map.layers;

imageLayer.toFront();