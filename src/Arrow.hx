import starling.display.Image;
import starling.textures.Texture;
import starling.utils.MathUtil;
import starling.events.KeyboardEvent;
import flash.ui.Keyboard;
import starling.core.Starling;
import starling.display.Quad;

class Arrow extends Image
{
	var orientation:Float;
	var angle:Float;
	var speed:Float;
	var radius:Float;
	var xcenter:Float;
	var ycenter:Float;

	public var arrowXCenter:Float;
	public var arrowYCenter:Float;
	
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
		move();		
	}
	
	// Updates the position of the arrow based on user input
	public function move()
	{
	
		Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN,
			function(event:KeyboardEvent){				
				if (event.keyCode == Keyboard.LEFT) {
					angle = (angle + .03)%(Math.PI*2);
					x = xcenter + radius * Math.cos(angle);
					y = ycenter + radius * Math.sin(angle);

					arrowXCenter = xcenter + (radius-15) * Math.cos(angle);
					arrowYCenter = ycenter + (radius-15) * Math.sin(angle);
					rotation = angle;
					//trace(angle, x, y, rotation);
				}
				if (event.keyCode == Keyboard.RIGHT){
					angle = (angle - .03)%(Math.PI*2);
					x = xcenter + radius * Math.cos(angle);
					y = ycenter + radius * Math.sin(angle);

					arrowXCenter = xcenter + (radius-15) * Math.cos(angle);
					arrowYCenter = ycenter + (radius-15) * Math.sin(angle);
					rotation = angle;
					//trace(angle, x, y, rotation);
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
				if (event.keyCode == Keyboard.DOWN){
					if (radius < 320)
					{
						radius = radius + 50;
						x = xcenter + radius * Math.cos(angle);
						y = ycenter + radius * Math.sin(angle);

						arrowXCenter = xcenter + (radius-15) * Math.cos(angle);
						arrowYCenter = ycenter + (radius-15) * Math.sin(angle);
					}					
				}
			});
		
	}
}