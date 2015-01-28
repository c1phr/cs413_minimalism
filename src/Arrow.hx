import starling.display.Image;
import starling.textures.Texture;
import starling.utils.MathUtil;
import starling.events.KeyboardEvent;
import flash.ui.Keyboard;
import starling.core.Starling;

class Arrow extends Image
{
	var orientation:Float;
	var angle:Float;
	var speed:Float;
	var radius:Float;
	var xcenter:Float;
	var ycenter:Float;
	
	public function new(tex:Texture, radius, xcenter, ycenter, angle, speed)
	{
		
		// Create an arrow
		super(tex);
		pivotX = this.texture.width / 2;
		pivotY = this.texture.height;
		this.xcenter = xcenter;
		this.ycenter = ycenter;
		x = xcenter;
		y = ycenter;
		this.angle = angle;
		this.speed = speed;
		this.radius = radius;
		
		this.rotation = -1.5;
		move();
		
	}
	
	// Updates the position of the arrow based on user input
	public function move()
	{
	
		Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN,
			function(event:KeyboardEvent){
				trace(event.keyCode);
				if (event.keyCode == Keyboard.LEFT) {
					angle = (angle + speed)%(Math.PI*2);
					x = xcenter - radius * Math.cos(angle);
					y = ycenter - radius * Math.sin(angle);
					rotation = angle - .25;
					//trace(angle, x, y, rotation);
					}
				if (event.keyCode == Keyboard.RIGHT){
					angle = (angle + speed)%(Math.PI*2);
					x = xcenter + radius * Math.cos(angle);
					y = ycenter + radius * Math.sin(angle);
					rotation = angle - .25;
					//trace(angle, x, y, rotation);
					}
				if (event.keyCode == Keyboard.UP){
					radius = radius-50;
					}
				if (event.keyCode == Keyboard.DOWN){
					radius = radius+50;	
					}
				});
		
	}
}