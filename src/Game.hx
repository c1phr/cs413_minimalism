import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.display.Image;
import starling.core.Starling;
import starling.animation.Transitions;
import starling.display.Stage;
import starling.animation.Tween;
import starling.events.EnterFrameEvent;
import flash.geom.Rectangle;
import flash.geom.Point;

class Game extends Sprite
{	

    var arcList:List<Arc> = new List<Arc>();    
    var transitionSpeed = 0.5;
    public var bgcolor = 0;
    var arrow:Arrow;
    var rootSprite:Sprite;
    var center:Image;
	
	var radiusOffset = 0.0;
	
	public function onEnterFrame(event:EnterFrameEvent)
	{
        var centerPoint:Point = new Point(arrow.arrowXCenter, arrow.arrowYCenter);
        if (center.getBounds(this).containsPoint(centerPoint))
        {
            var gameOver = new GameOver(rootSprite);
            gameOver.start(true);
			cleanup();
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, function(event:EnterFrameEvent) {
				for (arc in arcList)
					arc.update(radiusOffset);
			});
			transitionOutWin(function() {
				this.removeFromParent();
				this.dispose();
			});
        }
		for (arc in arcList)
        {                
            arc.update(radiusOffset);
			//trace("(" + arc.radius + ") - (" + arrow.radius + ")");
			// Only check arcs on same radius level
            if (arc.radius == arrow.radius - 10)
            {
				var arcAngRange = 0.36;
				var arrAngRange = 0.07;
				
				var arrAngle = arrow.angle;
				var arcAngleLow = arc.angle - arcAngRange;
				var arcAngleHi = arc.angle;
				
				if (arrAngle + arcAngRange + arrAngRange > Math.PI * 2)
					arrAngle -= 2 * Math.PI;
					
				//trace("arr: " + (Math.fround(arrAngle * 100) / 100) +
				//		", arcL: " + (Math.fround(arcAngleLow * 100) / 100) +
				//		", arcH: " + (Math.fround(arcAngleHi * 100) / 100));
				
				if (arrAngle + arrAngRange*2 > arcAngleLow && arrAngle - arrAngRange < arcAngleHi)
				{	
					var gameOver = new GameOver(rootSprite);
					gameOver.start(false);
					cleanup();
					this.addEventListener(EnterFrameEvent.ENTER_FRAME, function(event:EnterFrameEvent) {
						for (arc in arcList)
							arc.update(radiusOffset);
					});
					transitionOutDeath(function() {
						this.removeFromParent();
						this.dispose();
					});
				}
            }            
        }
	}
	public function new(root:Sprite)
	{		
        this.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
        super();
	}
	
	public function startGame(root:Sprite)
    {    	
		var stage = Starling.current.stage;
        var stageXCenter:Float = Starling.current.stage.stageWidth / 2;
        var stageYCenter:Float = Starling.current.stage.stageHeight / 2;
        center = new Image(Root.assets.getTexture("Center"));
        this.rootSprite = root;
        center.x = (Starling.current.stage.stageWidth / 2) - (center.texture.width / 2);
        center.y = (Starling.current.stage.stageHeight / 2) - (center.texture.height / 2);
        this.addChild(center);

        // Keeping these in separate loops in case we want to change how individual rings are built
        for (ring1 in 0...3)
        {
            var arc = new Arc(Root.assets.getTexture("arc5"), 60, stageXCenter, stageYCenter, deg2rad(120 * ring1), .02);
            arcList.add(arc);
        }
		
        for (ring2 in 0...3)
        {
            var arc = new Arc(Root.assets.getTexture("arc4"), 110, stageXCenter, stageYCenter, deg2rad(240 * ring2), -.01);
            arcList.add(arc);
        }

        for (ring3 in 0...3)
        {
            var arc = new Arc(Root.assets.getTexture("arc3"), 160, stageXCenter, stageYCenter, deg2rad(240 * ring3), .015);
            arcList.add(arc);
        }

        for (ring4 in 0...3)
        {
            var arc = new Arc(Root.assets.getTexture("arc2"), 210, stageXCenter, stageYCenter, deg2rad(120 * ring4), -.02);
            arcList.add(arc);
        }

        for (ring5 in 0...3)
        {
            var arc = new Arc(Root.assets.getTexture("arc1"), 260, stageXCenter, stageYCenter, deg2rad(10 * ring5), .01);
            arcList.add(arc);
        }

        for (arc in arcList)
        {
            this.addChild(arc);
        }
        root.addChild(this);
		
		arrow = new Arrow(Root.assets.getTexture("Triangle"), 320, stageXCenter, stageYCenter,0);
        this.addChild(arrow);
    }
	
	private function cleanup() {
			this.removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			arrow.destroy();
	}
	
	private function transitionIn(?callBack:Void->Void) {
		
		var t = new Tween(this, transitionSpeed, Transitions.EASE_IN_OUT);
		t.animate("scaleX", 1);
		t.animate("scaleY", 1);
		t.animate("bgcolor", 255);
		t.onUpdate = function() {
			Starling.current.stage.color = this.bgcolor | this.bgcolor << 8 | this.bgcolor << 16;
		};
		t.onComplete = callBack;
		Starling.juggler.add(t);
	}
	
	private function transitionOutWin(?callBack:Void->Void) {
		
		var t = new Tween(this, transitionSpeed, Transitions.EASE_IN);
		t.animate("radiusOffset", Starling.current.stage.stageWidth / 2 + 100);
		t.onComplete = callBack;
		Starling.juggler.add(t);
		
		var t = new Tween(center, transitionSpeed, Transitions.EASE_IN);
		t.animate("scaleX", 0);
		t.animate("scaleY", 0);
		Starling.juggler.add(t);
		
		var t = new Tween(arrow, transitionSpeed, Transitions.EASE_IN);
		t.animate("scaleX", 0);
		t.animate("scaleY", 0);
		Starling.juggler.add(t);
		
	}
	
	public function transitionOutDeath(?callBack:Void->Void) {
		
		var t = new Tween(arrow, transitionSpeed, Transitions.EASE_IN_BACK);
		t.animate("y", y + Starling.current.stage.stageHeight + 100);
		t.onComplete = callBack;
		Starling.juggler.add(t);
		
		var t = new Tween(center, transitionSpeed, Transitions.EASE_IN_BACK);
		t.animate("y", y + Starling.current.stage.stageHeight + 100);
		Starling.juggler.add(t);
		
		for (arc in arcList) {
			
			var t = new Tween(arc, transitionSpeed, Transitions.EASE_IN_BACK);
			t.animate("y", y + Starling.current.stage.stageHeight + 100);
			Starling.juggler.add(t);
			
		}
	}


	
    public static function deg2rad(deg:Int)
    {
        return deg / 180.0 * Math.PI;
    }
	

}
