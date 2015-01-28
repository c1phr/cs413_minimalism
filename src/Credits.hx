
import starling.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.geom.Vector3D;
import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.core.Starling;
import starling.animation.Transitions;
import starling.animation.Tween;
import starling.display.Image;

class Credits extends Sprite {
	
	public var rootSprite:Sprite;
	
	private var transitionSpeed = 0.5;
	public var bgcolor = 255;
	
	private var names:List<Image>;
	
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
		this.scaleX = 1;
		this.scaleY = 1;
		
		Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleInput);
		
		names = new List<Image>();
		var texNames = ["harrisonlambeth",
						"jackburrell",
						"joshuaframpton",
						"ryanbatchelder",
						"seanbaquiro"];
		
		
		for (texName in texNames) {
			var name = new Image(Root.assets.getTexture(texName));
			
			// Choose random point on edge of screen
			var edge = Math.round(Math.random() * 4); // left = 0, top = 1, right = 2, bottom = 3
			if (edge == 0 || edge == 2)
				name.y = Math.random() * Starling.current.stage.stageHeight;
			else
				name.x = Math.random() * Starling.current.stage.stageWidth;
			
			if(edge == 0)
				name.x = -name.width * 1.25;
			else if(edge == 2)
				name.x = Starling.current.stage.stageWidth + name.width * 1.25;
			else if(edge == 1)
				name.y = -name.height * 2;
			else if (edge == 3)
				name.y = Starling.current.stage.stageHeight + name.height * 2;
			
			name.pivotY = name.height / 2;
			name.pivotX = Math.random() * name.width * 1.25;
			this.addChild(name);
			names.add(name);
		}
		
		rootSprite.addChild(this);
		
		transitionIn();
	}
	
	private function handleInput(event:KeyboardEvent) {
		
		if (event.keyCode == Keyboard.SPACE) {
		
			// Return
			var menu = new Main(rootSprite);
			menu.bgcolor = this.bgcolor;
			menu.start();
			Starling.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleInput);
			transitionOut(function() {
				this.removeFromParent();
				this.dispose();
			});
		}
		
	}
	
	private function transitionIn(?callBack:Void->Void) {
		
		var t = new Tween(this, transitionSpeed, Transitions.EASE_IN_OUT);
		t.animate("bgcolor", 0);
		t.onUpdate = function() {
			Starling.current.stage.color = this.bgcolor | this.bgcolor << 8 | this.bgcolor << 16;
		};
		t.onComplete = callBack;
		Starling.juggler.add(t);
		
		var center = new Vector3D(Starling.current.stage.stageWidth / 2, Starling.current.stage.stageHeight / 2);
		var i = 0;
		for (name in names) {
			var r_time = Math.random() * 0.5 - 0.25;
			t = new Tween(name, transitionSpeed + r_time, Transitions.EASE_IN_OUT);
			t.animate("x", center.x);
			t.animate("y", center.y + Math.round((i - names.length / 2) * 40));
			Starling.juggler.add(t);
			i++;
		}
	}
	
	private function transitionOut(?callBack:Void->Void) {
		
		var t = new Tween(this, transitionSpeed, Transitions.EASE_IN_OUT);
		t.onComplete = callBack;
		Starling.juggler.add(t);
		
		for (name in names) {
			var x:Float = 0.0;
			var y:Float = 0.0;
			// Choose random point on edge of screen
			var edge = Math.round(Math.random() * 4); // left = 0, top = 1, right = 2, bottom = 3
			if (edge == 0 || edge == 2)
				y = Math.random() * Starling.current.stage.stageHeight;
			else
				x = Math.random() * Starling.current.stage.stageWidth;
			
			if(edge == 0)
				x = -name.width * 1.25;
			else if(edge == 2)
				x = Starling.current.stage.stageWidth + name.width * 1.25;
			else if(edge == 1)
				y = -name.height * 2;
			else if (edge == 3)
				y = Starling.current.stage.stageHeight + name.height * 2;
			
			t = new Tween(name, transitionSpeed, Transitions.EASE_IN_OUT);
			t.animate("x", x);
			t.animate("y", y);
			Starling.juggler.add(t);
		}
	}

    public static function deg2rad(deg:Int)
    {
        return deg / 180.0 * Math.PI;
    }
	
}