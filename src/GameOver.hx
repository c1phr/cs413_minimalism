
import starling.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.geom.Vector3D;
import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.core.Starling;
import starling.animation.Transitions;
import starling.animation.Tween;
import starling.animation.DelayedCall;
import starling.display.Image;
import starling.events.EnterFrameEvent;

class GameOver extends Sprite {

    public var rootSprite:Sprite;
    public var arcList:List<Arc> = new List<Arc>();
    public var bgcolor = 0;
    private var bgscreen:List<Image>;
	private var transitionSpeed = 1.0;

    public function onEnterFrame(event:EnterFrameEvent)
    {
        for (arc in arcList)
        {
            arc.update(0);
        }
    }

    public function new(rootSprite:Sprite) {
        this.rootSprite = rootSprite;
        this.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
        super();
    }

    public function start(win:Bool) {

        Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleInput);
        bgscreen = new List<Image>();
        
        var text:Image;
        if (win)
        {
            text = new Image(Root.assets.getTexture("GameWon"));
        }
        else
        {
            text = new Image(Root.assets.getTexture("GameOver"));
        }
        rootSprite.addChild(this);
        this.addChild(text);

        var stage = Starling.current.stage;
        var stageXCenter:Float = Starling.current.stage.stageWidth / 2;
        var stageYCenter:Float = Starling.current.stage.stageHeight / 2;

        /*var delayedCall:DelayedCall = new DelayedCall(reverse, 3.0);
        delayedCall.repeatCount = 5;
        Starling.juggler.add(delayedCall);*/


        // Keeping these in separate loops in case we want to change how individual rings are built

        for (ring3 in 0...3)
        {
            var arc = new Arc(Root.assets.getTexture("arc3"), 275, stageXCenter, stageYCenter, deg2rad(240 * ring3), reverse(.02));
            arcList.add(arc);
        }

        for (ring4 in 0...3)
        {
            var arc = new Arc(Root.assets.getTexture("arc2"), 355, stageXCenter, stageYCenter, deg2rad(120 * ring4), reverse(-.015));
            arcList.add(arc);
        }

        for (ring5 in 0...3)
        {
            var arc = new Arc(Root.assets.getTexture("arc1"), 475, stageXCenter, stageYCenter, deg2rad(120 * ring5), reverse(.01));
            arcList.add(arc);
        }

        for (arc in arcList)
        {
            this.addChild(arc);
        }
        rootSprite.addChild(this);
		
		if (win)
		{
			scaleX = 8;
			scaleY = 8;
			x = stageXCenter * -7;
			y = stageYCenter * -7 - 300;
			transitionInWin();
		}
		else
		{
			scaleX = 0;
			scaleY = 0;
			x = stageXCenter;
			y = stageYCenter;
			transitionInLose();
		}

    }

    private function handleInput(event:KeyboardEvent) {

        if (event.keyCode == Keyboard.SPACE) {

            // Return
            var menu = new Main(rootSprite);
            menu.bgcolor = this.bgcolor;
            menu.start();
            Starling.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleInput);
			transitionSpeed = 0.5;
			transitionOut(function() {
                this.removeFromParent();
                this.dispose();
			});
        };
    }
    public static function deg2rad(deg:Int)
    {
        return deg / 180.0 * Math.PI;
    }

    public static function reverse(num:Float)
    {
        return num * -1;
    }
	
	private function transitionInWin(?callBack:Void->Void) {
		
		var t = new Tween(this, transitionSpeed, Transitions.EASE_IN_OUT);
		t.animate("scaleX", 1);
		t.animate("scaleY", 1);
		t.animate("x", 0);
		t.animate("y", 0);
		t.onComplete = callBack;
		Starling.juggler.add(t);
	}
	
	private function transitionInLose(?callBack:Void->Void) {
		
		var t = new Tween(this, transitionSpeed, Transitions.EASE_IN_OUT);
		t.animate("scaleX", 1);
		t.animate("scaleY", 1);
		t.animate("x", 0);
		t.animate("y", 0);
		t.onComplete = callBack;
		Starling.juggler.add(t);
		
		var t = new Tween(this, transitionSpeed*0.05, Transitions.EASE_OUT);
		t.animate("bgcolor", 255);
		t.onUpdate = function() {
			Starling.current.stage.color = this.bgcolor | this.bgcolor << 8 | this.bgcolor << 16;
		};
		t.onComplete = function() {
			var t = new Tween(this, transitionSpeed*0.45, Transitions.EASE_IN_OUT);
			t.animate("bgcolor", 0);
			t.onUpdate = function() {
				Starling.current.stage.color = this.bgcolor | this.bgcolor << 8 | this.bgcolor << 16;
			};
			Starling.juggler.add(t);
		}
		Starling.juggler.add(t);
	}
	
	private function transitionOut(?callBack:Void->Void) {
		
        var stageXCenter:Float = Starling.current.stage.stageWidth / 2;
        var stageYCenter:Float = Starling.current.stage.stageHeight / 2;
		var t = new Tween(this, transitionSpeed, Transitions.EASE_IN_OUT);
		t.animate("scaleX", 0);
		t.animate("scaleY", 0);
		t.animate("x", stageXCenter);
		t.animate("y", stageYCenter);
		t.onComplete = callBack;
		Starling.juggler.add(t);
	}
}
