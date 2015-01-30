import starling.display.Image;
import starling.textures.Texture;
import starling.utils.MathUtil;
import starling.events.KeyboardEvent;
import starling.events.EnterFrameEvent;
import flash.ui.Keyboard;
import starling.core.Starling;
import starling.display.Quad;

class Arrow extends Image
{
	public var orientation:Float;
	public var angle:Float;
	public var speed:Float;
	public var radius:Float;
	public var xcenter:Float;
	public var ycenter:Float;

	public var arrowXCenter:Float;
	public var arrowYCenter:Float;
	
	var leftDown = false;
	var rightDown = false;
	
	public function new(tex:Texture, radius, xcenter, ycenter, angle)
	{
		
		// Create an arrow
		super(tex);
		pivotX = this.texture.width;
		pivotY = this.texture.height / 2;
		this.xcenter = xcenter;
		this.ycenter = ycenter;
		
		this.angle = angle;
		this.radius = radius;
		
		this.rotation = angle;
		x = xcenter + radius * Math.cos(angle);
		y = ycenter + radius * Math.sin(angle);
		init();		
	}
	
	public function init() {
		Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		Starling.current.stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		this.addEventListener(EnterFrameEvent.ENTER_FRAME, enterFrame);
	}
	
	public function destroy() {
		Starling.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		Starling.current.stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
	}
	
	public function keyDown(event:KeyboardEvent) {
		
		if (event.keyCode == Keyboard.LEFT) {
			leftDown = true;
		}
		if (event.keyCode == Keyboard.RIGHT) {
			rightDown = true;
		}
		if (event.keyCode == Keyboard.UP){
			if (radius > 50)
			{
				radius = radius - 50;
				x = xcenter + radius * Math.cos(angle);
				y = ycenter + radius * Math.sin(angle);
				arrowXCenter = xcenter + (radius-15) * Math.cos(angle);
				arrowYCenter = ycenter + (radius-15) * Math.sin(angle);
			}					
		}
		if (event.keyCode == Keyboard.DOWN) {
			if (radius < 320)
			{
				radius = radius + 50;
				x = xcenter + radius * Math.cos(angle);
				y = ycenter + radius * Math.sin(angle);

				arrowXCenter = xcenter + (radius-15) * Math.cos(angle);
				arrowYCenter = ycenter + (radius-15) * Math.sin(angle);
			}
		}
	}
	
	public function keyUp(event:KeyboardEvent) {
		
		if (event.keyCode == Keyboard.LEFT) {
			leftDown = false;
		}
		if (event.keyCode == Keyboard.RIGHT){
			rightDown = false;
		}
	}
	
	public function enterFrame(event:EnterFrameEvent) {
		
		if (leftDown) {
			
			angle = arithMod((angle + .025), (Math.PI * 2));
			x = xcenter + radius * Math.cos(angle);
			y = ycenter + radius * Math.sin(angle);

			arrowXCenter = xcenter + (radius-15) * Math.cos(angle);
			arrowYCenter = ycenter + (radius-15) * Math.sin(angle);
			rotation = angle;
		} else if (rightDown) {
			
			angle = arithMod((angle - .025), (Math.PI * 2));
			x = xcenter + radius * Math.cos(angle);
			y = ycenter + radius * Math.sin(angle);

			arrowXCenter = xcenter + (radius-15) * Math.cos(angle);
			arrowYCenter = ycenter + (radius-15) * Math.sin(angle);
			rotation = angle;
		}
	}
	
	public function arithMod(n:Float, d:Float) : Float {
		var r = n % d;
		if (r < 0)
			r += d;
		return r;
	}
}