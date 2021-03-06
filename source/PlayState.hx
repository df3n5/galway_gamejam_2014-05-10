package; 

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
    public var level:TiledLevel;

    /*
       public var score:FlxText;
       public var status:FlxText;
     */
    public var enemies:FlxGroup;
    public var player:FlxSprite;
    public var floor:FlxObject;
    public var exit:FlxSprite;
    public var glitchMode:Bool;
    public var glitched:Bool; //last time glitched

    private var youDied:Bool = false;
    private var jumpVelocity:Float;
    private var levelNo:Int;
    private var moveSpeed:Float;
    private var music:FlxSound;
    public var overlay:FlxSprite;

    public static var MAX_LEVELS = 6;

    public function new(levelNo:Int, glitched:Bool, died:Bool):Void {
        super();
        this.levelNo = levelNo;

        this.glitchMode = glitched;
        this.youDied = died;
    }

    public override function create():Void {
        FlxG.mouse.visible = false;

        glitchMode = false;

        //super.create();
        bgColor = 0xffaaaaaa;

        // Load the level's tilemaps
        level = new TiledLevel("assets/tiled/level" + levelNo + ".tmx");

        // Add background tiles after adding level objects, so these tiles render on top of player
        add(level.backgroundTiles);

        // Add tilemaps
        add(level.foregroundTiles);

        // Draw coins first
        enemies = new FlxGroup();
        add(enemies);

        // Load player objects
        level.loadObjects(this);

        level.backgroundTiles.visible = false;

        /*
        // Create UI
        score = new FlxText(2, 2, 80);
        score.scrollFactor.set(0, 0); 
        score.borderColor = 0xff000000;
        score.borderStyle = FlxText.BORDER_SHADOW;
        score.text = "SCORE: " + (coins.countDead() * 100);
        add(score);

        status = new FlxText(FlxG.width - 160 - 2, 2, 160);
        status.scrollFactor.set(0, 0);
        status.borderColor = 0xff000000;
        score.borderStyle = FlxText.BORDER_SHADOW;
        status.alignment = "right";
         */

        /*
           if (youDied == false) {
           status.text = "Collect coins.";
           } else {
           status.text = "Aww, you died!";
           }
         */
        jumpVelocity = -player.maxVelocity.y / 2;
        music = null;

        //		add(status);
        moveSpeed = player.maxVelocity.x;
        if(FlxG.sound.music != null) {
            FlxG.sound.music.stop();
        }
        FlxG.sound.playMusic("assets/sounds/Gameloop.wav", 0.3, true);

        if(youDied) {
            if(glitched) {
                FlxG.sound.play("assets/sounds/GlitchDeath.wav");
            } else {
                FlxG.sound.play("assets/sounds/Death.wav");
            }
        } else {
            if(glitchMode){
                FlxG.sound.play("assets/sounds/GlitchWin.wav");
            } else {
                FlxG.sound.play("assets/sounds/Win.wav");
            }
        }
        this.overlay = new FlxSprite("assets/tiled/Overlay.png");
        this.overlay.visible = false;
        overlay.scrollFactor.x = 0;
        overlay.scrollFactor.y = 0;
        add(this.overlay);
    }

    override public function update():Void 
    {
        player.acceleration.x = 0;
        if (FlxG.keys.justPressed.SPACE) {
            glitchMode = ! glitchMode;
            if(glitchMode) {
                if(FlxG.sound.music != null) {
                    FlxG.sound.music.stop();
                }
                FlxG.sound.playMusic("assets/sounds/Glitchloop.wav", 0.3, true);
                //FlxG.camera.color = 0x00FF00FF;
                jumpVelocity = -player.maxVelocity.y;
                //moveSpeed = player.maxVelocity.x * 100000;
                moveSpeed = player.maxVelocity.x * 22;
                this.overlay.visible = true;
                level.foregroundTiles.visible = false;
                level.backgroundTiles.visible = true;

            } else {
                if(FlxG.sound.music != null) {
                    FlxG.sound.music.stop();
                }
                FlxG.sound.playMusic("assets/sounds/Gameloop.wav", 0.3, true);
                //FlxG.camera.color = 0xFFFFFFFF;
                jumpVelocity = -player.maxVelocity.y / 2;
                moveSpeed = player.maxVelocity.x;
                this.overlay.visible = false;
                level.foregroundTiles.visible = true;
                level.backgroundTiles.visible = false;
            }
        }

        if (FlxG.keys.justPressed.ONE) {
            FlxG.switchState(new PlayState(1, true, true));
        }
        if (FlxG.keys.justPressed.TWO) {
            FlxG.switchState(new PlayState(2, true, true));
        }
        if (FlxG.keys.justPressed.THREE) {
            FlxG.switchState(new PlayState(3, true, true));
        }
        if (FlxG.keys.justPressed.FOUR) {
            FlxG.switchState(new PlayState(4, true, true));
        }
        if (FlxG.keys.justPressed.FIVE) {
            FlxG.switchState(new PlayState(5, true, true));
        }

        var nothingPressed = true;
        if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.A) {
            nothingPressed = false;
            //player.acceleration.x = -moveSpeed;
            player.velocity.x = -moveSpeed;
            //player.facing = FlxObject.LEFT;
            player.flipX = true;
        }
        if (FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.D) {
            nothingPressed = false;
            //player.acceleration.x = moveSpeed;
            player.velocity.x = moveSpeed;
            //player.facing = FlxObject.RIGHT;
            player.flipX = false;
        }
        if (FlxG.keys.pressed.W && player.isTouching(FlxObject.FLOOR)) {
            nothingPressed = false;
            //player.velocity.y = -player.maxVelocity.y / 2;
            player.velocity.y = jumpVelocity;

            if(glitchMode){
                FlxG.sound.play("assets/sounds/GlitchJump.wav");
            }else {
                FlxG.sound.play("assets/sounds/Jump.wav");
            }
        }
        super.update();
        if(glitchMode) {
            exit.animation.play("weird");
            if(nothingPressed) {
                player.animation.play("stop");
            } else {
                player.animation.play("walk");
                player.drag.x = 0;
            }
        } else {
            exit.animation.play("normal");
            if(nothingPressed) {
                player.animation.play("normalstop");
            } else {
                player.animation.play("normalwalk");
                player.drag.x = player.maxVelocity.x * 4;
            }
        }

        FlxG.overlap(enemies, player, collideEnemy, pixelPerfectProcess);

        // Collide with foreground tile layer
        level.collideWithLevel(player);
        FlxG.overlap(exit, player, win, pixelPerfectProcess);
        if (FlxG.overlap(player, floor)) {
            youDied = true;
            FlxG.switchState(new PlayState(this.levelNo, glitchMode, true));
        }
    }

    public function win(Exit:FlxObject, Player:FlxObject):Void
    {
        player.kill();
        if((this.levelNo+1) == MAX_LEVELS) {
            FlxG.switchState(new FinishState());
        } else {
            FlxG.switchState(new PlayState(this.levelNo+1, glitchMode, false));
        }
    }

    public function getCoin(Coin:FlxObject, Player:FlxObject):Void
    {
        Coin.kill();
        //score.text = "SCORE: " + (coins.countDead() * 100);
        /*
           if (coins.countLiving() == 0)
           {
           status.text = "Find the exit";
           exit.exists = true;
           }
         */
    }

    public function collideEnemy(enemy:FlxObject, player:FlxObject):Void {
        youDied = true;
        FlxG.switchState(new PlayState(this.levelNo, glitchMode, true));
    }

    public function addEnemy(enemy:FlxObject):Void {
        this.add(enemy);
        this.enemies.add(enemy);
    }

    private function pixelPerfectProcess(officer:FlxObject, bullet:FlxObject):Bool {
        var castBullet:FlxSprite = cast(bullet, FlxSprite);
        var castOfficer:FlxSprite = cast(officer, FlxSprite);
        if(FlxG.pixelPerfectOverlap(castBullet, castOfficer)) {
            return true;
        }
        return false;
    }
}
