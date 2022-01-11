package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

/**
 * A demo of creating a HUD camera with transparent background that
 * overlays the bottom middle of the game's main camera.
 */
class HUDCameraOverlayState extends FlxState
{
	// World size - the game size is 640 x 480
	public final worldWidth = 4000;
	public final worldHeight = 2000;

	// Original camera
	var originalCamera:FlxCamera;

	// Block to follow
	var block:FlxSprite;

	override public function create()
	{
		super.create();

		// Get ref to original camera
		originalCamera = FlxG.camera;

		// Create background to make game extent visible
		var testImage = new FlxSprite().loadGraphic(AssetPaths.CameraTestImage__png);
		testImage.cameras = [originalCamera];
		add(testImage);

		// Setting scroll bounds simplifies update code as you do not have
		// to have additional code to check where the camera has scrolled to.
		// It can be set by one of two APIs.
		// originalCamera.setScrollBounds(0, worldWidth, 0, worldHeight);
		originalCamera.setScrollBoundsRect(0, 0, worldWidth, worldHeight);

		// Create HUD camera
		// Set it to overlay the bottom 50 pixels of the screen. It is
		// 100 pixels narrower than the game and centered.
		var hudWidth = FlxG.width - 100;
		var hudHeight = 50;
		var hudX = Math.round((FlxG.width - hudWidth) / 2);
		var hudY = Math.round(FlxG.height - hudHeight);
		var hudCamera = new FlxCamera(hudX, hudY, hudWidth, hudHeight);
		hudCamera.bgColor = FlxColor.TRANSPARENT;

		// Add the HUD camera
		FlxG.cameras.add(hudCamera);

		// Create the HUD itself and add it to the HUD camera
		var hud = new HUD(hudCamera);
		add(hud);

		// Add test sprite for the originalCamera to follow
		// This block represents perhaps a player. It can be moved with the
		// arrow keys and sent home (0, 0) with the HOME key.
		block = new FlxSprite();
		block.makeGraphic(50, 50, FlxColor.BLACK, true);
		block.cameras = [originalCamera];
		add(block);

		originalCamera.follow(block);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// Move the 'player'
		if (FlxG.keys.pressed.LEFT)
		{
			block.x -= 10;
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			block.x += 10;
		}
		if (FlxG.keys.pressed.UP)
		{
			block.y -= 10;
		}
		if (FlxG.keys.pressed.DOWN)
		{
			block.y += 10;
		}
		if (FlxG.keys.pressed.HOME)
		{
			block.x = 0;
			block.y = 0;
		}
		if (FlxG.keys.justReleased.ESCAPE)
		{
			FlxG.switchState(new MenuState());
		}
	}
}
