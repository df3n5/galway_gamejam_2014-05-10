import flixel.FlxG;           
import flixel.group.FlxGroup; 
import flixel.util.FlxPoint;
import flixel.FlxSprite;      
import flixel.FlxObject;      

class Enemy2 extends FlxSprite {
    var origPos : FlxPoint;
    var speed = 30.0;
    public function new(x,y) {
        super(x, y);
        //this.loadGraphic("assets/images/Stationary.png");
        this.loadGraphic("assets/images/Enemy.png", true, 64, 64);
        this.animation.add("normal", [0, 1], 5, true);
        this.animation.play("normal");
        origPos = new FlxPoint(x, y);
        this.facing = FlxObject.UP;
        this.velocity.y = -speed;
    }

    override public function update():Void {
        super.update();       
        var DELTA = 100;
        if(this.facing == FlxObject.UP) {
            if(y < this.origPos.y - DELTA) {
                this.facing = FlxObject.DOWN;
                this.velocity.y = speed;
            }
        }
        if(this.facing == FlxObject.DOWN) {
            if(y > this.origPos.y + DELTA) {
                this.facing = FlxObject.UP;
                this.velocity.y = -speed;
            }
        }
    }
}
