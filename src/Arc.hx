import starling.display.Image;
import starling.textures.Texture;
import starling.utils.MathUtil;

class Arc extends Image
{
	var orientation:Float;
	var angle:Float;
	var speed:Float;
	var radius:Float;
	var xcenter:Float;
	var ycenter:Float;
	
	public function new(tex:Texture, radius, xcenter, ycenter, angle, speed)
	{
		
		// Create a new arc with the texture
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
		
	}
	
	// Updates the position of the arc based on the radius and speed desired
	public function update()
	{
		angle = (angle + speed)%(Math.PI*2);
		x = xcenter + radius * Math.cos(angle);
		y = ycenter + radius * Math.sin(angle);
		rotation = angle - .25;
		//trace(angle, x, y, rotation);
	}
}