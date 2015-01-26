package com.cs413.cs413_minimalism;

import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.display.Image;
import starling.core.Starling;
import starling.animation.Transitions;
import starling.display.Stage;

class Game 
{
	function new()
	{
		startGame();
	}

	public function startGame()
    {
        var center = new Image(Root.assets.getTexture("Center"));
        center.x = (Starling.current.stage.stageWidth / 2) - (center.texture.width / 2);
        center.y = Starling.current.stage.stageHeight / 2 - (center.texture.height / 2);
        addChild(center);
        /*for (ring in 0...4)
        {            
            if (ring == 0)
            {
                var arc = new Arc(Root.assets.getTexture("arc1"));
                arc.x = 
            }
            rings.add(ring);

        }*/
    }
	

}