
import starling.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.geom.Vector3D;
import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.core.Starling;
import starling.animation.Transitions;
import starling.animation.Tween;
import starling.display.Image;

class Main extends Sprite {
	
	public var rootSprite:Sprite;
	
	private var selection:Int;
	private var buttons:Array<Image>;
	
	private var rotateSpeed = 0.3;
	private var transitionSpeed = 0.5;
	private var tween:Tween;
	public var bgcolor = 255;
	
	public function new(rootSprite:Sprite) {
		this.rootSprite = rootSprite;
		super();
	}
	
	public function start() {
		
		var center = new Vector3D(Starling.current.stage.stageWidth / 2, Starling.current.stage.stageHeight / 2);
		this.pivotX = center.x;
		this.pivotY = center.y;
		this.x = center.x;
		this.y = center.y;
		this.scaleX = 8;
		this.scaleY = 8;
		
		buttons = [new Image(Root.assets.getTexture("Start")), new Image(Root.assets.getTexture("Quit")), new Image(Root.assets.getTexture("Credits"))];
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
		
		Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleInput);
		
		selection = 0;
		
		rootSprite.addChild(this);
		
		transitionIn();
	}
	
	private function handleInput(event:KeyboardEvent) {
		
		if (event.keyCode == Keyboard.SPACE) {
		
			if (selection == 0) {
				// Start
				
				var game = new Game(rootSprite);
				game.bgcolor = this.bgcolor;
				game.startGame(rootSprite);
				Starling.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleInput);
				transitionOut(function() {
					this.removeFromParent();
					this.dispose();
				});
			}
			else if (selection == 1) {
				// Credits
				var credits = new Credits(rootSprite);
				credits.bgcolor = this.bgcolor;
				credits.start();
				Starling.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleInput);
				transitionOut(function() {
					this.removeFromParent();
					this.dispose();
				});

			}
			else
			{
			    // Quit goes to GameOver screen
				var gameover = new GameOver(rootSprite);
				//credits.bgcolor = this.bgcolor;

				gameover.start(false);
				Starling.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleInput);
				transitionOut(function() {
					this.removeFromParent();
					this.dispose();
				});
			}
		}
		else if (tween == null || tween.isComplete)
		{
			// Only allow moving if the current tween does not exist.
			if (event.keyCode == Keyboard.LEFT) {
				selection = arithMod(--selection, buttons.length);
				
				var x = selection == 0 ? 0 : 360;
				tween = new Tween(this, rotateSpeed, Transitions.EASE_IN_OUT);
				tween.animate("rotation", deg2rad(Math.round(360 / buttons.length) * selection - x));
				Starling.juggler.add(tween);
			}
			else if (event.keyCode == Keyboard.RIGHT) {
				selection = arithMod(++selection, buttons.length);
				
				tween = new Tween(this, rotateSpeed, Transitions.EASE_IN_OUT); 
				tween.animate("rotation", deg2rad(Math.round(360 / buttons.length) * selection));
				Starling.juggler.add(tween);
			}
		}
		
	}
	
	private function transitionIn(?callBack:Void->Void) {
		
		var t = new Tween(this, transitionSpeed, Transitions.EASE_IN_OUT);
		t.animate("scaleX", 1);
		t.animate("scaleY", 1);
		t.animate("bgcolor", 0);
		t.onUpdate = function() {
			Starling.current.stage.color = this.bgcolor | this.bgcolor << 8 | this.bgcolor << 16;
		};
		t.onComplete = callBack;
		Starling.juggler.add(t);
	}
	
	private function transitionOut(?callBack:Void->Void) {
		
		var t = new Tween(this, transitionSpeed, Transitions.EASE_IN_OUT);
		t.animate("scaleX", 8);
		t.animate("scaleY", 8);
		t.onComplete = callBack;
		Starling.juggler.add(t);
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
