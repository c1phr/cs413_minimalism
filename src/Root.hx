import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.display.Image;
import starling.core.Starling;
import starling.animation.Transitions;
import starling.display.Stage;

class Root extends Sprite {

    public static var assets:AssetManager;    
    // There's probably a better way to do this
    // This array makes each ring addressable, with each ring containing a list of arcs
    public var rings = [for (x in 0...4) new List<Arc>()];

    public function new() {
        super();
    }

    public function start(startup:Startup) {

        assets = new AssetManager();
        //assets.enqueue("assets/ninja.png");
        for (num in 1...5)
        {            
            assets.enqueue("assets/arc" + num + ".png");
        }
        assets.enqueue("assets/Center.png");
        assets.enqueue("assets/Circle.png");
        assets.loadQueue(function onProgress(ratio:Float) {
            haxe.Log.clear();
            trace(ratio);
            if (ratio == 1) {
                haxe.Log.clear();
                startGame();
                // Start the game

/*                Starling.juggler.tween(startup.loadingBitmap, 2.0, {
                    transition: Transitions.EASE_OUT,
                        delay: 0.0,
                        alpha: 0,
                        onComplete: function() {
                        startup.removeChild(startup.loadingBitmap);
                        ninja = new Image(Root.assets.getTexture("ninja"));
                        ninja.x = 100;
                        ninja.y = 0;
                        addChild(ninja);

                        Starling.juggler.tween(ninja, 1.0, {
                            transition: Transitions.EASE_OUT_BOUNCE,
                                delay: 2.0,
                                y: 250
                                });

                    }

                });*/
            }

        });
    }

    public function startGame()
    {
        var center = new Image(Root.assets.getTexture("Center"));
        center.x = (Starling.current.stage.stageWidth / 2) - (center.texture.width / 2);
        center.y = Starling.current.stage.stageHeight / 2 - (center.texture.height / 2);
        addChild(center);
/*        for (ring in 0...4)
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
