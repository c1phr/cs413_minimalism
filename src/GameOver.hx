
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
    public var bgcolor = 255;
    private var bgscreen:List<Image>;

    public function onEnterFrame(event:EnterFrameEvent)
    {
        for (arc in arcList)
        {
            arc.update();
        }
    }

    public function new(rootSprite:Sprite) {
        this.rootSprite = rootSprite;
        this.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
        super();
    }


    public function start(root:Sprite) {

        Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleInput);
        bgscreen = new List<Image>();
        var text = new Image(Root.assets.getTexture("GameOver"));
        rootSprite.addChild(this);
        this.addChild(text);

        var stage = Starling.current.stage;
        var stageXCenter:Float = Starling.current.stage.stageWidth / 2;
        var stageYCenter:Float = Starling.current.stage.stageHeight / 2;

        var delayedCall:DelayedCall = new DelayedCall(reverse, 3.0);
        delayedCall.repeatCount = 5;
        Starling.juggler.add(delayedCall);


        // Keeping these in separate loops in case we want to change how individual rings are built
    /*
        for (ring1 in 0...3)
        {
            var arc = new Arc(Root.assets.getTexture("arc5"), 60, stageXCenter, stageYCenter, deg2rad(120 * ring1), .01);
            arcList.add(arc);
        }

        for (ring2 in 0...3)
        {
            var arc = new Arc(Root.assets.getTexture("arc4"), 200, stageXCenter, stageYCenter, deg2rad(240 * ring2), -.02);
            arcList.add(arc);
        }
    */
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
        root.addChild(this);

    }

    private function handleInput(event:KeyboardEvent) {

        if (event.keyCode == Keyboard.SPACE) {

            // Return
            var menu = new Main(rootSprite);
            menu.bgcolor = this.bgcolor;
            menu.start();
            Starling.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleInput);

                this.removeFromParent();
                this.dispose();
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
}
