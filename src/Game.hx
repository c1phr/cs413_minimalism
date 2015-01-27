import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.display.Image;
import starling.core.Starling;
import starling.animation.Transitions;
import starling.display.Stage;

class Game 
{
	public function new(root:Sprite)
	{
		startGame(root);
	}

	public function startGame(root:Sprite)
    {
    	// There's probably a better way to do this
	    // This array makes each ring addressable, with each ring containing a list of arcs
	    var rings = [for (x in 0...4) new List<Arc>()];
		var stage = Starling.current.stage;
        var center = new Image(Root.assets.getTexture("Center"));
        center.x = (Starling.current.stage.stageWidth / 2) - (center.texture.width / 2);
        center.y = (Starling.current.stage.stageHeight / 2) - (center.texture.height / 2);
        root.addChild(center);

        var clockwiseArc = new Sprite();
        clockwiseArc.width = stage.stageWidth;
        clockwiseArc.height = stage.stageHeight;
        clockwiseArc.x = stage.stageWidth / 2;                
        clockwiseArc.y = stage.stageHeight /2;
        clockwiseArc.pivotX = stage.stageWidth /2;
        clockwiseArc.pivotY = stage.stageHeight / 2;                
        
        Starling.juggler.tween(clockwiseArc, 5.0, {
            transition: Transitions.LINEAR,
            rotation: deg2rad(360)
        });

        root.addChild(clockwiseArc);

        for (ring in 0...4)
        {            
            if (ring == 0)
            {
                for (i in 0...2)
                {
                    var arc = new Arc(Root.assets.getTexture("arc5"));                    
                    arc.y = center.y + (center.texture.height/2);

                    if (i % 2 == 0)
                    {
                        arc.x = center.x + center.texture.width;
                    }
                    else
                    {   
                        arc.rotation = deg2rad(180);                     
                        arc.x = center.x;
                        
                    }
                    rings[ring].add(arc);
                    clockwiseArc.addChild(arc);
                }
                
            }

        }

    }

    public static function deg2rad(deg:Int)
    {
        return deg / 180.0 * Math.PI;
    }
	

}