package sketches.ik.core
{
	import caurina.transitions.Tweener;
	
	import flash.display.Sprite;
	
	import mx.core.UIComponent;

    public class Chain extends UIComponent
    {
		private var start_x:int;
		private var start_y:int;
		
		private var items:Vector.<ChainPoint>;
        private var vel_x:Number;
        private var vel_y:Number;
        private var speed:Number;
        private var theta:Number;
        private var graphics_box_ref:Sprite;

        public function Chain(xp:Number, yp:Number, spacing:Number, length:int, thet:Number, init_spd:Number, graphics_box:Sprite, start_x:int=0, start_y:int = 0)
        {
			this.start_x = start_x;
			this.start_y = start_y;
            this.items = new Vector.<ChainPoint>;
            this.theta = Math.random() * 5000;
            this.speed = init_spd;
            this.vel_x = Math.cos(this.theta) * this.speed;
            this.vel_y = Math.sin(this.theta) * this.speed;
            this.graphics_box_ref = graphics_box;
            this.build_chain(xp, yp, length, spacing);
        }

        private function build_chain(xp:Number, yp:Number, amo:int, spacing:Number) : void
        {
            var count:int = 0;
            while (count < amo)
            {
                this.items.push(new ChainPoint(xp, yp, spacing));
				count++
            }
        }

        private function move_points_mouse() : void
        {
            Tweener.removeAllTweens();
            Tweener.addTween(this.items[0], {x:this.mouseX - this.start_x, y:this.mouseY - this.start_y, time:1});
            var i:int = 1;
            while (i < this.items.length)
            {
                this.items[i].update_self(this.items[(i - 1)]);
                i++;
            }
        }

        private function move_points() : void
        {
            this.theta = this.theta + 3.14 / this.randomRange(-50, 50);
            this.vel_x = Math.cos(this.theta) * this.speed;
            this.vel_y = Math.sin(this.theta) * this.speed;
            this.items[0].x = this.items[0].x + this.vel_x;
            this.items[0].y = this.items[0].y + this.vel_y;
            var i:int = 1;
            while (i < this.items.length)
            {
                this.items[i].update_self(this.items[(i - 1)]);
                i++;
            }

        }

		private function draw_chain(col:uint = 0) : void
		{
			var move_x:Number = 0;
			var move_y:Number = 0;
			this.graphics_box_ref.graphics.lineStyle(1, col, 0.1);
			var i:int = 0;
			while (i < this.items.length)
			{
				if (i == 0)
				{
					this.graphics_box_ref.graphics.moveTo(this.start_x + this.items[i].x, this.start_y + this.items[i].y);
				}
				else
				{
					move_x = (this.items[i].x - this.items[(i - 1)].x) / 2;
					move_y = (this.items[i].y - this.items[(i - 1)].y) / 2;
					this.graphics_box_ref.graphics.curveTo(this.start_x + this.items[(i - 1)].x + move_x, start_y + this.items[(i - 1)].y + move_y, this.start_x + this.items[i].x, start_y + this.items[i].y);
				}
				i = i + 1;
			}
		}

        public function update(col:uint = 0) : void
        {
            this.move_points_mouse();
            this.draw_chain(col);
        }

        private function randomRange(max:Number, min:Number = 0) : Number
        {
            return Math.random() * (max - min) + min;
        }

    }
}
