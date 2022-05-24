package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

/**
 * A demo of creating a HUD below the game's main camera.
 * The HUD camera is however only 1/4 of the window width. So when you scroll to the
 * left HUD elements will disappear to the right and vice versa.
 * This is a split-screen setup.
 */
class CameraScrollState extends FlxState
{
	// World size - the game size is 640 x 480
	public final worldWidth = 4000;
	public final worldHeight = 2000;

	// Original camera
	var originalCamera:FlxCamera;
	// HUD Camera
	var hudCamera:FlxCamera;

	// Block to follow
	var block:FlxSprite;

	var _hud:HUD;

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

		// Shrink original camera to be 50 pixels shorter.
		originalCamera.height = FlxG.height - 50;

		// Create HUD camera
		// Set it to occupy the bottom 50 pixels of the screen. Make it only
		// 1/4 of the screen width.
		var hudWidth = Math.floor(FlxG.width / 4);
		var hudHeight = 50;
		var hudX = Math.round((FlxG.width - hudWidth) / 2);
		var hudY = Math.round(FlxG.height - hudHeight);
		hudCamera = new FlxCamera(hudX, hudY, hudWidth, hudHeight);
		hudCamera.bgColor = FlxColor.GRAY;
		hudCamera.alpha = 0.4;

		// Add the HUD camera
		FlxG.cameras.add(hudCamera);

		// Create the HUD itself and add it to the HUD camera
		_hud = new HUD(hudCamera);
		add(_hud);

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

		// Move 'HUD Camera'
		if (FlxG.keys.pressed.LEFT)
		{
			hudCamera.scroll.x -= 10;
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			hudCamera.scroll.x += 10;
		}
		if (FlxG.keys.pressed.HOME)
		{
			hudCamera.scroll.x = 0;
		}
		if (FlxG.keys.justReleased.ESCAPE)
		{
			FlxG.switchState(new MenuState());
		}
	}
}
