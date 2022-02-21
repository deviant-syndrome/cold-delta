(Require("bootstrap.scd");

// currentEnvironment.use({
// 	~context.valueEnvir(exec: { | const_HI_THROB |
// 			SynthDef(\test, { | out = 0 |
// 				var impulse = Impulse.kr(1);
// 				var sound = SinOsc.ar(440, 0, EnvGen.ar(Env.perc(0.2, 1), impulse));
// 				SendTrig.kr(impulse, 0, const_HI_THROB);
// 				Out.ar(out, sound ! 2);
// 			}).add;
// 	});
// });

~globalRouting[\throbe][\jack].value(\throbBlast);
~globalRouting[\throbe][\send].value(\throbListenHigh);

)

(
	s.freeAll;
)

(
	s.makeGui();
)

(
	~globalRouting[\throbe][\gain].set(\gains, 0.00);
)
