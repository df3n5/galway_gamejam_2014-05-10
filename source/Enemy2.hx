import flixel.FlxG;           
import flixel.group.FlxGroup; 
import flixel.util.FlxPoint;
import flixel.FlxSprite;      
import flixel.FlxObject;      

class Enemy2 extends FlxSprite {
    var origPos : FlxPoint;
    var speed = 30.0;
    var level:TiledLevel;
    var state:PlayState;

    public function new(x,y, level:TiledLevel, playState:PlayState) {
        super(x, y);
        //this.loadGraphic("assets/images/Stationary.png");
        this.loadGraphic("assets/images/Enemy.png", true, 64, 64);
        this.animation.add("normal", [0, 1], 5, true);
        this.animation.play("normal");
        this.animation.add("glitched", [2, 3], 5, true);
        origPos = new FlxPoint(x, y);
        this.facing = FlxObject.UP;
        this.velocity.y = -speed;
        this.level = level;
        this.state = playState;
    }

    override public function update():Void {
        super.update();       
        var DELTA = 100;
        if(this.level.collideWithLevel(this)) {
            if(this.facing == FlxObject.UP) {
                this.facing = FlxObject.DOWN;
                this.velocity.y = speed;
            } else {
                this.facing = FlxObject.UP;
                this.velocity.y = -speed;
            }
        }
        if(this.state.glitchMode) {
            this.animation.play("glitched");
        } else {
            this.animation.play("normal");
        }
/*
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
*/
    }
}
