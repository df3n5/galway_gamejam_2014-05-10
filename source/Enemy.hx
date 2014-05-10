import flixel.FlxG;           
import flixel.group.FlxGroup; 
import flixel.util.FlxPoint;
import flixel.FlxSprite;      
import flixel.FlxObject;      

class Enemy extends FlxSprite {
    var origPos : FlxPoint;
    var speed = 30.0;
    public function new(x,y) {
        super(x, y);
        //this.loadGraphic("assets/images/Stationary.png");
        this.loadGraphic("assets/images/Enemy.png", true, 64, 64);
        this.animation.add("normal", [0, 1], 5, true);
        this.animation.play("normal");
        origPos = new FlxPoint(x, y);
        this.facing = FlxObject.LEFT;
        this.velocity.x = -speed;
    }

    override public function update():Void {
        super.update();       
        var DELTA = 100;
        if(this.facing == FlxObject.LEFT) {
            if(x < this.origPos.x - DELTA) {
                this.facing = FlxObject.RIGHT;
                this.velocity.x = speed;
            }
        }
        if(this.facing == FlxObject.RIGHT) {
            if(x > this.origPos.x + DELTA) {
                this.facing = FlxObject.LEFT;
                this.velocity.x = -speed;
            }
        }
    }
}
