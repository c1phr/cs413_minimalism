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
        assets.enqueue("assets/Triangle.png");
		
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
		
		// Game Over
        /*	assets.enqueue("assets/GameOver.png");
        	assets.enqueue("assets/Reset.png");*/
		
        assets.loadQueue(function onProgress(ratio:Float) {
            haxe.Log.clear();
            trace(ratio);
            if (ratio == 1) {
                haxe.Log.clear();
                var menu = new Main(rootSprite);
                menu.start();
                //var game = new Game(rootSprite);
				// 
            }

        });
		
    }
}
