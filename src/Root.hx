import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.display.Image;
import starling.core.Starling;
import starling.animation.Transitions;
import starling.display.Stage;
import starling.events.EnterFrameEvent;

class Root extends Sprite {

    public static var assets:AssetManager;
    public var rootSprite:Sprite;

	public static function init() {
		
	}
	
    public function new() {
        rootSprite = this;
        super();
    }
	


    public function start(startup:Startup) {

        assets = new AssetManager();
        //assets.enqueue("assets/ninja.png");
        for (num in 1...6)
        {            
            assets.enqueue("assets/arc" + num + ".png");
        }
        assets.enqueue("assets/Center.png");
        assets.enqueue("assets/Circle.png");
		
		// Menu Items
        assets.enqueue("assets/Start.png");
        assets.enqueue("assets/Quit.png");
        assets.enqueue("assets/Credits.png");
		
		// Credits
		assets.enqueue("assets/harrisonlambeth.png");
		assets.enqueue("assets/jackburrell.png");
		assets.enqueue("assets/joshuaframpton.png");
		assets.enqueue("assets/ryanbatchelder.png");
		assets.enqueue("assets/seanbaquiro.png");
		
        assets.loadQueue(function onProgress(ratio:Float) {
            haxe.Log.clear();
            trace(ratio);
            if (ratio == 1) {
                haxe.Log.clear();
                //startGame();
                var game = new Game(rootSprite);
				this.addEventListener(EnterFrameEvent.ENTER_FRAME, game.onEnterFrame);				
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
	
/*    public function startGame()
    {
        var stage = Starling.current.stage;
        var center = new Image(Root.assets.getTexture("Center"));
        center.x = (Starling.current.stage.stageWidth / 2) - (center.texture.width / 2);
        center.y = (Starling.current.stage.stageHeight / 2) - (center.texture.height / 2);
        addChild(center);

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

        addChild(clockwiseArc);

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

    }*/

    

}
