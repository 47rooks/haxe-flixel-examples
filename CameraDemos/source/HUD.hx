package;

import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using flixel.util.FlxSpriteUtil;

/**
 * A very simplistic HUD with just a health bar and some text.
 * Construction requires a camera which is to display the HUD. All
 * objects set their cameras to this.
 */
class HUD extends FlxTypedGroup<FlxSprite>
{
	var _camera:FlxCamera;

	var _health:Int;

	public function new(camera:FlxCamera)
	{
		super();
		_camera = camera;
		_createHud();
	}

	private function _createHud()
	{
		var lineStyle:LineStyle = {color: FlxColor.BLACK, thickness: 1};
		var drawStyle:DrawStyle = {smoothing: true};
		var border = new FlxSprite(0, 0);
		border.makeGraphic(_camera.width, _camera.height, FlxColor.TRANSPARENT, true);
		border.drawRect(0, 0, _camera.width, _camera.height, FlxColor.TRANSPARENT, lineStyle, drawStyle);
		add(border);

		var hudTitle = new FlxText(5, 5, -1, "This is the HUD\nAll HUD items are drawn within (0,0) to (_camera.width, _camera.height)");
		add(hudTitle);

		var healthLabel = new FlxText(_camera.width - 140, 5, "Health");
		add(healthLabel);
		var healthBar = new FlxBar(_camera.width - 100, 5, LEFT_TO_RIGHT, 80, 10, this, "_health", 0, 100, true);
		add(healthBar);

		// Update the health in the HUD randomly every second
		// This is just to demonstrate how a health bar might look.
		new FlxTimer().start(1, (t:FlxTimer) ->
		{
			_health = Math.round(Math.random() * 100);
		}, 0);
	}

	/**
	 * Override add so that it also sets the camera for this sprite.
	 * @param obj the FlxSprite to add
	 * @return FlxSprite for chaining
	 */
	override public function add(obj:FlxSprite):FlxSprite
	{
		super.add(obj);
		obj.cameras = [_camera];
		return obj;
	}
}
