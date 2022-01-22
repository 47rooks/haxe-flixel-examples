package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxSpriteAniRot;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

/**
 * TODO
 * 3. putting a border around the camera to separate it from the other camera display. Do I need to blit ?
 */
class WorldCameraState extends FlxState
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

		// Create background to make game extent visible
		var testImage = new FlxSprite().loadGraphic(AssetPaths.CameraTestImage__png);
		add(testImage);

		// Get ref to original camera
		originalCamera = FlxG.camera;

		// Setting scroll bounds simplifies update code as you do not have
		// to have additional code to check where the camera has scrolled to.
		// It can be set by one of two APIs.
		// originalCamera.setScrollBounds(0, worldWidth, 0, worldHeight);
		originalCamera.setScrollBoundsRect(0, 0, worldWidth, worldHeight);

		// Create world camera
		var wcWidth = 100;
		var wcHeight = 50;
		var wcX = 20;
		var wcY = Math.round(FlxG.height - wcHeight * 1.1);
		var worldCamera = new WorldCamera(wcX, wcY - wcHeight, wcWidth, 2 * wcHeight, worldWidth, worldHeight);

		// Add camera to world
		// If you change the second argument to false then FlxBasics added to the FlxState will not be rendered
		// on this camera.
		FlxG.cameras.add(worldCamera, true);

		// Add a block the worldCamera
		// This just demostrates the effect of adding a block to the world camera only.
		// It appears just inside the yellow border in the overlaid camera.
		var arrow = new FlxSprite();
		arrow.makeGraphic(50, 50, FlxColor.BLACK, true);
		arrow.x = 100;
		arrow.y = 100;
		arrow.cameras = [worldCamera];
		add(arrow);

		// Add test sprite for the originalCamera to follow
		// This block represents perhaps a player. It can be moved with the
		// arrow keys and sent home (0, 0) with the HOME key.
		block = new FlxSprite();
		block.makeGraphic(50, 50, FlxColor.BLACK, true);
		add(block);

		originalCamera.follow(block);

		// Block to demonstrate alpha on overlaid cameras works for
		// objects that are registered only the original camera.
		// They show through the worldCamera viewport only when they are
		// behind that viewport onscreen. As you scroll the player down
		// the red block will move out from behind the worldCamera and
		// no longer show through. The player block on the other will
		// remain visible in the worldCamera.
		var block2 = new FlxSprite();
		block2.x = 50;
		block2.y = 250;
		block2.makeGraphic(50, 50, FlxColor.RED, true);
		block2.cameras = [originalCamera];
		add(block2);

		// Add some text above the 0, 0 to demonstrate that if the camera
		// reaches up there this text will appear.
		var t = new FlxText(0, 0, -1, "This is the world camera", 120);
		t.color = FlxColor.BLACK;
		t.x = 0;
		t.y = -200;
		t.cameras = [worldCamera];
		add(t);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

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
