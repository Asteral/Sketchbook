package com
{
	import sketches.ik.IK_MouseAction;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;

	public class MainPage extends Canvas
	{
		public static const WIDTH:int = 500;
		public static const HEIGHT:int = 500;
		
		private var frame_count:int=0;
		private var ik:IK_MouseAction;
		private var rendering:Boolean;
		
		private var bg_col:uint = 0xFFF;
		
		public function MainPage()
		{
			this.addChild(new BasicInfo());
			
			ik = new IK_MouseAction(WIDTH, HEIGHT);
			this.addChild(ik);

			this.addEventListener(Event.ENTER_FRAME, update);
			rendering = true;
			this.addEventListener(MouseEvent.CLICK, toggle_render);
		}
		
		private function update(evt:Event):void
		{
			frame_count++;
			ik.ticktock_frames();
			if(frame_count % 375 == 0) {
				frame_count = 0;
				invert_draw(null);
			}
		}
		
		private function invert_draw(evt:Event):void
		{
			this.ik.restart_invert();
		}
		
		private function toggle_render(evt:Event):void
		{/*
			if(rendering){
				this.removeEventListener(Event.ENTER_FRAME, update);
				rendering = false;
			} else {
				this.addEventListener(Event.ENTER_FRAME, update);
				rendering = true;
			}
		*/
		}

	}
}