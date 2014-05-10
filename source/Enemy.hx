import flixel.FlxG;           
import flixel.group.FlxGroup; 
import flixel.util.FlxPoint;
import flixel.FlxSprite;      

class Enemy extends FlxSprite {
    public function new(x,y) {
        super(x, y);
        //this.loadGraphic("assets/images/Stationary.png");
        this.loadGraphic("assets/images/Enemy.png", true, 64, 64);
        this.animation.add("normal", [0, 1], 5, true);
        this.animation.play("normal");

    }

    override public function update():Void {
        super.update();       
    }
}
