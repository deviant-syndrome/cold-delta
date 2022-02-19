~guitarAmpRig = {

}
// Routing:
// Channel strip types:
//     Standard: gain -> vol
//       Insert: gain -> insert -> vol
//       Master: limiter

// Channels
//     1 : Drum Track / Sync generator [Standard]
//     2 :
(
	SynthDef(\insert, { arg bus;
    	ReplaceOut.ar(bus, VSTPlugin.ar(In.ar(bus, 2), 2));
	}).add;

	~synth = Synth(\insert, [\bus, 0]);
	~fx = VSTPluginController(~synth);
	~fx.open("/Library/Audio/Plug-Ins/VST3/Emissary.vst3", verbose: true);
	~fx.gui;
)
(
	~fx.gui;
)
(
	var channel1 = Bus.audio(s);
    var channel2 = Bus.audio(s);
	
	var ch1, ch1_input;
	// create a simple fx channel
	SynthDef(\channelGain, { | gains = 0.5, out = 0 |
		var gained = In.ar(0, 2) * gains;
		ReplaceOut.ar(out , gained );
	}).add;

	~ch1 = Group.basicNew(s, 1);
	~ch1_gain = Synth.tail(ch1, \channelGain);
)
(
	~ch1.dumpTree;
	~ch1_gain.set(\gains, 0.7);

	~ch_gains = [~ch1_gain, ~ch2_gain]
)

(
	w = Window.new("My Anima Hates Me", Rect(200,200,300,400));

	2.do { arg i;
		var mute = Button.new(w,Rect(10,30 * i,50,30)).states_([["Mute"],["Unmute"]]);
		var solo = Button.new(w,Rect(60,30 * i,50,30)).states_([["Solo"],["Unsolo"]]);
		var gain = Slider.new(w,Rect(115,30 * i,150,30));
		gain.action = { postln(gain.value); }
	};
	ServerMeterView.new(s, w, 0@80, 2, 4);

	w.front;
	//l = Slider.new(w,Rect(115,0,150,30));
	// c = CompositeView.new(w,Rect(20,35,100,60));
	// StaticText.new(c,Rect(0,0,80,30)).string_("Hello");
	// StaticText.new(c,Rect(20,30,80,30)).string_("World!");
	//b.action = { c.visible = b.value.asBoolean.not };
	// l.action = { c.bounds = Rect( l.value * 150 + 20, 35, 100, 100 ) };
	// w.front;
)
