package;

import flixel.FlxCamera;
import flixel.math.FlxPoint;

class WorldCamera extends FlxCamera
{
	/**
	 * Construct a new WorldCamera
	 * 
	 * @param x the x location in screen pixels of the top left corner of the camera
	 * @param y the y location in screen pixels of the top left corner of the camera
	 * @param w the width of the camera window in screen pixels
	 * @param h the height of the camera window in screen pixels
	 * @param worldWidth the width of the world to be displayed in the camera in world pixels
	 * @param worldHeight the height of the world to be displayed in the camera in world pixels
	 */
	public function new(x:Int, y:Int, w:Int, h:Int, worldWidth:Int, worldHeight:Int)
	{
		super(x, y, w, h);

		// Set key camera properties
		var xZoom = w / worldWidth;
		var yZoom = h / worldHeight;
		var initialZoom = xZoom < yZoom ? xZoom : yZoom;

		alpha = .4;
		scroll.x = 0;
		scroll.y = 0;
		zoom = initialZoom;
		focusOn(new FlxPoint(worldWidth / 2.0, worldHeight / 2.0));
	}

	// Uncomment and implement resize code if necessary
	//   Custom resize behaviour appears to be one reason to extend FlxCamera rather than delegate.
	// override public function onResize() {
	//     super.onResize();
	// }
}
