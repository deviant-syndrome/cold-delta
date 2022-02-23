(
Require("bootstrap.scd");

topEnvironment[\become].value(topEnvironment[\playBasicRiff]);

)

(
~globalRouting[\chuggs][\gain].set(\gains, 0.4);
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
