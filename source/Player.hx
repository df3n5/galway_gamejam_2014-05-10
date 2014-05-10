import flixel.FlxG;           
import flixel.group.FlxGroup; 
import flixel.util.FlxPoint;
import flixel.FlxSprite;      

class Player extends FlxSprite {
    public function new(x,y) {
        super(x, y);
        //this.loadGraphic("assets/images/Stationary.png");
        this.loadGraphic("assets/images/Run.png", true, 64, 64);
        this.animation.add("walk", [0, 1, 2, 3, 4, 8, 5, 6, 7], 10, true);
        this.animation.play("walk");

        this.animation.add("stop", [8], 10, true);

        this.animation.add("normalwalk", [9, 10, 11, 12], 10, true);
        this.animation.add("normalstop", [9], 10, true);
    }

    override public function update():Void {
        super.update();       
    }
}
