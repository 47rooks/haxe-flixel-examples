package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.ui.FlxUIButton;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	static final LEFT_X = 10;
	static final TOP_Y = 20;
	static final LINE_Y = 60;
	static final TITLE_Y = 80;
	static final DESC_X = 140;
	static final TEXT_LENGTH = 450;

	static final BASE_FONT_SIZE = 16;

	var _row:Int;

	override public function create()
	{
		super.create();

		// Set the font, rather globally
		FlxAssets.FONT_DEFAULT = "assets/fonts/OpenSans-Regular.ttf";

		// Add menu of camera demos
		_row = TOP_Y;
		var title = new FlxText(LEFT_X, _row, "Camera Demos", 48);
		add(title);

		_row += TITLE_Y;

		addMenuItem("World Camera", () ->
		{
			FlxG.switchState(new WorldCameraState());
		},
			"A camera which shows the whole world overlaid on the main screen which shows only player's neighborhood.");

		_row += LINE_Y;

		addMenuItem("HUD Overlay", () ->
		{
			FlxG.switchState(new HUDCameraOverlayState());
		},
			"A camera which shows user information overlaid on the main screen which shows only player's neighborhood.");

		_row += LINE_Y;

		addMenuItem("HUD Separate", () ->
		{
			FlxG.switchState(new HUDCameraSeparateState());
		},
			"A camera which shows user information at the bottom of the screen. The main screen is split with player camera above and HUD camera below.");

		_row += 2 * LINE_Y;

		add(new FlxText(LEFT_X, _row, "Hit <ESC> to return to this menu from the demo", BASE_FONT_SIZE));
	}

	/**
	 * Add an item consisting of one FlxUIButton and a FlxText description.
	 * 
	 * It will handle making them all consistent and centering the button in the description row.
	 * @param buttonLabel label for the button
	 * @param buttonCbk the callback to for the button click operation
	 * @param description the description of the demo that the button will launch
	 */
	private function addMenuItem(buttonLabel:String, buttonCbk:Void->Void, description:String)
	{
		var button = new FlxUIButton(LEFT_X, _row, buttonLabel, buttonCbk);
		var desc = new FlxText(DESC_X, _row, TEXT_LENGTH, description, BASE_FONT_SIZE);
		button.resize(120, 40);
		button.y = _row + (desc.height - button.height) / 2;
		button.setLabelFormat(14, FlxColor.BLACK, FlxTextAlign.CENTER);
		add(button);
		add(desc);
	}
}
