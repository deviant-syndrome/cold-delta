(Require("bootstrap.scd");

SynthDef(\test, { | out = 0 |
	var sound = SinOsc.ar(440, 0, EnvGen.ar(Env.perc(0.2, 1), Impulse.ar(1)));
	Out.ar(out, sound ! 2);
}).add;

~globalRouting[\throbe][\jack].value(\test);
)

(
	~globalRouting[\throbe][\gain].set(\gains, 3.5);
)
