import starling.display.Image;
import starling.textures.Texture;
import starling.utils.MathUtil;
import flash.geom.Rectangle;

class Arc extends Image
{
	public var orientation:Float;
	public var angle:Float;
	public var speed:Float;
	public var radius:Float;
	public var xcenter:Float;
	public var ycenter:Float;
	
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
	public function update(radiusOffset:Float) : Rectangle
	{
		var rad = radius + radiusOffset;
		
		angle = arithMod((angle + speed), (Math.PI * 2));
		x = xcenter + rad * Math.cos(angle);
		y = ycenter + rad * Math.sin(angle);
		rotation = angle - .25;
		//trace(angle, x, y, rotation);
		return this.bounds;
	}
	
	public function arithMod(n:Float, d:Float) : Float {
		var r = n % d;
		if (r < 0)
			r += d;
		return r;
	}
}