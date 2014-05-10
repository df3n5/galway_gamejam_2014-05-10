package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.tweens.misc.ColorTween;
import flixel.tweens.FlxTween;

class FinishState extends FlxState {

    override public function create():Void {
        var sprite = new FlxSprite(0, 0, "assets/images/finish.png");
        add(sprite);
    }

    override public function destroy():Void {
        super.destroy();
    }

    override public function update():Void {
        super.update();
        //text.alpha = tween.alpha;
        if(FlxG.keys.pressed.SPACE || FlxG.mouse.justPressed) {
            FlxG.switchState(new PlayState(0));
        }
    }   
}
