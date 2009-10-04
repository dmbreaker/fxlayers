package org.fxlayers;

import javafx.scene.*;
import javafx.scene.text.*;

public class Control extends CustomNode {
	public var map: Map;
	
	public function setMap(map: Map) {
	    this.map = map
	}
	
	public function activate() {
	    
	}

	override public function create(): Node {
		
		Text {
		    x: 10
		    y: 50
		    font: Font { size: 20 }
		    content: "This is a test"
		}
	}
}