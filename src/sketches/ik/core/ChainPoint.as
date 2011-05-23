package sketches.ik.core
{
	import mx.core.UIComponent;

    public class ChainPoint extends UIComponent
    {
        private var move_dist:Number;

        public function ChainPoint(xp:Number, yp:Number, mov_dist:Number)
        {
            this.move_dist = mov_dist;
            this.x = yp;
            this.y = xp;
        }

        public function update_self(parent:ChainPoint) : void
        {
            var theta:Number = Math.atan2((this.y - parent.y), (this.x - parent.x));
            this.x = parent.x + Math.cos(theta) * this.move_dist;
            this.y = parent.y + Math.sin(theta) * this.move_dist;
        }
    }
}
