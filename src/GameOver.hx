import starling.utils.AssetManager;
import starling.display.Sprite;
import starling.core.Starling;

@:bitmap("assets/GameOver.png")
class EndingBitmapData extends flash.display.BitmapData {}

class GameOver extends Sprite
{
    public var endingBitmap:Bitmap;
    public var assets:AssetManager;
    public var rootSprite:Sprite;

    public function end()
    {
        super();
        rootSprite = this;
        endingBitmap = new Bitmap(new EndingBitmapData(0, 0));
        endingBitmap.x = 0;
        endingBitmap.y = 0;
        endingBitmap.width = flash.Lib.current.stage.stageWidth;
        endingBitmap.height = flash.Lib.current.stage.stageHeight;
        endingBitmap.smoothing = true;
        addChild(endingBitmap);

        flash.Lib.current.stage.addEventListener(flash.events.Event.RESIZE,
        function(e:flash.events.Event) {
            Starling.current.viewPort = new Rectangle(0, 0,
            flash.Lib.current.stage.stageWidth,
            flash.Lib.current.stage.stageHeight);
            if (loadingBitmap != null) {
                loadingBitmap.width = flash.Lib.current.stage.stageWidth;
                loadingBitmap.height = flash.Lib.current.stage.stageHeight;
            }});

        var mStarling = new Starling(Root, flash.Lib.current.stage);
        mStarling.antiAliasing = 0;
        function onRootCreated(event:Dynamic, root:Root) {
            mStarling.removeEventListener(starling.events.Event.ROOT_CREATED,
            onRootCreated);
            root.start(this);
            mStarling.start();
        }
        mStarling.addEventListener(starling.events.Event.ROOT_CREATED,
        onRootCreated);
    }

    static function main() {
        var stage = flash.Lib.current.stage;
        stage.addChild(new Main());
    }

}
