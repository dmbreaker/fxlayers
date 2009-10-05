package org.fxlayers;

import javafx.scene.*;

public class Control extends CustomNode {
	public var map: Map;
	
	public function setMap(map: Map) {
	    this.map = map
	}
	
	public function activate() {
	    
	}

	override public function create(): Node {
		Group {}
	}
}