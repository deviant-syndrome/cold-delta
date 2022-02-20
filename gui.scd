w = Window.new("My Anima Hates Me", Rect(200,200,300,400));

2.do { arg i;
	var mute = Button.new(w,Rect(10,30 * i,50,30)).states_([["Mute"],["Unmute"]]);
	var solo = Button.new(w,Rect(60,30 * i,50,30)).states_([["Solo"],["Unsolo"]]);
	var gain = Slider.new(w,Rect(115,30 * i,150,30));
	gain.action = { postln(gain.value); }
};
ServerMeterView.new(s, w, 0@80, 2, 4);

w.front;
