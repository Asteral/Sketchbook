package sketches.ik
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	import sketches.ik.core.Chain;

    public class IK_MouseAction extends UIComponent
    {
        private var ikchains:Vector.<Chain>;
        private var draw_canvas:Sprite;
        private var display_canvas:Bitmap;
        private var col:uint;
        private var count:int = 0;
        public static const POINT_SPACING:int = 5;
        public static const CHAIN_LENGTH:int = 150;
        public static const INIT_SPEED:int = 5;
        public static const CHAIN_AMO:int = 1;

        public function IK_MouseAction(w:Number, h:Number)
        {
            this.width = w;
            this.height = h;
            this.col = 0;
            this.display_canvas = new Bitmap(new BitmapData(this.width, this.height));
            this.display_canvas.cacheAsBitmap = true;
            this.addChild(this.display_canvas);
            this.draw_canvas = new Sprite();
            this.construct_chains(CHAIN_AMO);
        }

        private function construct_chains(amo:int) : void
        {
            var theta:Number = 0;
            var xp:Number = NaN;
            var yp:Number = NaN;
            var chain:Chain;
            this.ikchains = new Vector.<Chain>;
            var i:int = 0;
            while (i < amo)
            {
				theta = i * (6.28 / amo);
				xp = Math.cos(theta) * 25;
				yp = Math.sin(theta) * 25;
				chain = new Chain(xp, yp, POINT_SPACING, CHAIN_LENGTH, 0, INIT_SPEED, this.draw_canvas, this.width/2, this.height/2);
                this.ikchains.push(this.addChild(chain));
                i++;
            }
        }

        public function ticktock_frames() : void
        {
			this.count++;

            for each (var chain:Chain in this.ikchains)
            {
				chain.update(this.col);
            }
            this.display_canvas.bitmapData.draw(this.draw_canvas);
            this.draw_canvas.graphics.clear();
        }

        private function fade_canvas() : void
        {
            if (this.count % 25 == 0)
            {
                this.count = 0;
				var color_transform:ColorTransform = new ColorTransform();
				color_transform.blueOffset = 1;
				color_transform.redOffset = 1;
				color_transform.greenOffset = 1;
				var rect:Rectangle = this.display_canvas.bitmapData.rect;
                this.display_canvas.bitmapData.colorTransform(rect, color_transform);
            }
        }

        public function restart_invert() : void
        {
            this.col = this.change_col();
        }

        private function change_col() : uint
        {
            return Math.random() * 0xFFFFFF;
        }

    }
}
