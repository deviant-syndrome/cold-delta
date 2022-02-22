(Require("bootstrap.scd");


// ~globalRouting[\throbe][\jack].value(\throbBlast);
// ~globalRouting[\throbe][\send].value(\throbListenHigh);
// ~globalRouting[\chuggs][\gain].set(\gains, 0.3);

~globalRouting[\chuggs][\vstInsert].value("/Library/Audio/Plug-Ins/VST3/NadIR.vst3", true);
~globalRouting[\chuggs][\vstInsert].value("/Library/Audio/Plug-Ins/VST3/Emissary.vst3");

// ~globalRouting[\throbe][\gain].set(\gains, 0.0);

~globalRouting[\throbe][\jack].value(\throbBlast);
~globalRouting[\throbe][\send].value(\throbListenHigh);

// TempoClock.tempo = 200/60;
// ~player = Pbind(
// 	\instrument, \steelString,
// 	\group, ~globalRouting[\chuggs][\strip],
// 	\dur, 0.25,
// 	\amp, 0.2,
// 	\stroke, Pseq([0, 1], inf),
// 	\out, ~globalRouting[\chuggs][\busNum]
// ).play;

)

(
	~player.stop;
	s.freeAll;
)

(
	s.makeGui();
)

(
	SynthDef(\test, { | out = 0 |
		var impulse = Impulse.kr(1);
		var sound = SinOsc.ar(440, 0, EnvGen.ar(Env.perc(0.2, 1), impulse));
		Out.ar(out, sound ! 2);
	}).add;
)

(
	~globalRouting[\chuggs][\gain].set(\gains, 0.35);
)
