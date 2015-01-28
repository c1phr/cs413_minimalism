
import starling.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.geom.Vector3D;
import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.core.Starling;
import starling.animation.Transitions;
import starling.animation.Tween;
import starling.display.Image;

class GameOver extends Sprite {

    public var rootSprite:Sprite;
    private var names:List<Image>;

    public function new(rootSprite:Sprite) {
        this.rootSprite = rootSprite;
        super();
    }

    public function start() {

        Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleInput);
        names = new List<Image>();
        var name = new Image(Root.assets.getTexture("GameOver"));
        rootSprite.addChild(this);
        this.addChild(name);

    }

    private function handleInput(event:KeyboardEvent) {

        if (event.keyCode == Keyboard.SPACE) {

// Return
            var menu = new Main(rootSprite);
            //menu.bgcolor = this.bgcolor;
            menu.start();
            Starling.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleInput);

                this.removeFromParent();
                this.dispose();
        };
    }
}
