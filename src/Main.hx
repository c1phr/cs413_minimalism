
import starling.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.geom.Vector3D;
import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.core.Starling;
import starling.animation.Transitions;

class Main extends Sprite {
	
	public var assets:AssetManager;
	public var rootSprite:Sprite;
	
	private var selection:Int;
	private var buttons:Array<Arc>;
	
	private var rotateSpeed = 0.5;
	
	public function new(rootSprite:Sprite) {
		this.rootSprite = rootSprite;
		super();
	}
	
	public function start() {
		
		assets = new AssetManager();
		for (num in 1...6)
        {            
            assets.enqueue("assets/arc" + num + ".png");
        }
        assets.enqueue("assets/Start.png");
        assets.enqueue("assets/Quit.png");
		
		var center = new Vector3D(Starling.current.stage.stageWidth / 2, Starling.current.stage.stageHeight / 2);
		this.pivotX = center.x;
		this.pivotY = center.y;
		this.x = center.x;
		this.y = center.y;
		
		Starling.current.stage.color = 0x000000;
		
		assets.loadQueue(function onProgress(ratio:Float) {
            haxe.Log.clear();
            trace(ratio);
            if (ratio == 1) {
                haxe.Log.clear();
				
				buttons = [new Arc(assets.getTexture("Start")), new Arc(assets.getTexture("Quit")), new Arc(assets.getTexture("Quit"))];
				for (i in 0...buttons.length) {
					var button = buttons[i];
					//button.x = 0;
					//button.y = 0;
					button.x = center.x;
					button.y = center.y;
					button.pivotX = button.width / 2;
					button.pivotY = -113;
					button.rotation = deg2rad(Math.round(360/buttons.length * i));
					this.addChild(button);
				}
            }
		});
		
		Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleInput);
		
		selection = 0;
		
		rootSprite.addChild(this);
	}
	
	private function handleInput(event:KeyboardEvent) {
		if (event.keyCode == Keyboard.SPACE) {
		
			if(selection == 0) {
				Starling.current.stage.color = 0xffffff;
				Starling.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleInput);
				this.removeFromParent();
				this.dispose();
				var game = new Game(rootSprite);
			}
			else
			{
				//trace("boop");
			}
		}
		else if (event.keyCode == Keyboard.LEFT) {
			selection = arithMod(--selection, buttons.length);
			
			var x = selection == 0 ? 0 : 360;
			Starling.juggler.tween(this, rotateSpeed, {
				transition: Transitions.LINEAR,
				rotation: deg2rad(Math.round(360/buttons.length) * selection - x)
			});
			
			trace(Math.round(360 / buttons.length) * selection);
		}
		else if (event.keyCode == Keyboard.RIGHT) {
			selection = arithMod(++selection, buttons.length);
			
			Starling.juggler.tween(this, rotateSpeed, {
				transition: Transitions.LINEAR,
				rotation: deg2rad(Math.round(360/buttons.length) * selection)
			});
			
			trace(Math.round(360 / buttons.length) * selection);
		}
		trace(selection);
		
	}

    public static function deg2rad(deg:Int)
    {
        return deg / 180.0 * Math.PI;
    }
	
	public static function arithMod(n:Int, d:Int) : Int {
		
		var r = n % d;
		if (r < 0)
			r += d;
		return r;
		
	}
	
}