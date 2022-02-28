(
Require("bootstrap.scd");
//
// postln(topEnvironment);

topEnvironment[\become].value(topEnvironment[\playMovement1]);
//
// topEnvironment[\become].value(Dictionary.newFrom([
// 		\onSet, {}
// 	]));
//
// // ~player = Pbind(
// 	\instrument, Pseq([\steelString6, \steelString5], inf),
// 	\dur, 2
// 	).play;

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
SynthDef("help-Dust", { arg out=0;
    Out.ar(out,
        Dust.ar(0.4, 0.2)
    )
}).play;
)
(
    p = Pdfsm(
		   [
			   Pseq( [\reprise, \reprise, \reprise, \coda], inf ),
			   (
				   \reprise : [0, Pseq([0, 4, 4, 3, Rest(), 2, 1, Rest(), 6, 7], 1)],
				   \coda : [0, Pseq([-4, 4, 4, 3, Rest(), 2, 1, Rest(), 6, 7], 1)]
			   )
		   ],
		   0,
		   inf
	   ).asStream;
)

(
    p.next.postln;
	// postln("-----")
)

(
SynthDef(\bells, { |out=0, freq=440, amp=0.5, gate=1, c3=17, pan=0, bufnum = 0|
	var snd, snd2;
	var env = Env.perc(0.01, 0.8);
		var env2 = Env.adsr(0.01, 0.5, 0.3, 1.4);


	var body = RLPF.ar(Saw.ar(freq, EnvGen.ar(env, gate, doneAction: 2)), XLine.ar(1800, 160, 0.5)) ! 2;

		var freqBase=freq;
		var freqRes=SinOsc.kr(Rand(0,1),0).range(freqBase / 2,freqBase * 2);
		var pdbase=Impulse.ar(freqBase);
		var pd=Phasor.ar(pdbase,2*pi*freqBase/s.sampleRate,0,2pi);
		var pdres=Phasor.ar(pdbase,2*pi*freqRes/s.sampleRate,0,2pi);
		var pdi=LinLin.ar((2pi-pd).max(0),0,2pi,0,1);
		snd2=Lag.ar(SinOsc.ar(0,pdres)*pdi,1/freqBase).dup;
		snd2=Splay.ar(snd2);
	snd2=snd2*EnvGen.ar(Env.perc(0.1,1.4)) * 0.1;

	    snd =  body + snd2;
		snd = snd*0.1 + BBandPass.ar(snd, 751,0.075) + BBandPass.ar(snd, 1460,0.075) + BBandPass.ar(snd, 2841,0.075);


	Out.ar(0, snd * 0.1);

}).add;
)

(
	var synth = SynthDescLib.global.at(\bowedHell);

	var controls = synth.controls;
	controls
)

(
	SynthDef(\test, { | out = 0 |
		var impulse = Impulse.kr(1);
		var sound = SinOsc.ar(440, 0, EnvGen.ar(Env.perc(0.2, 1), impulse));
		Out.ar(out, sound ! 2);
	}).add;
)

(
var a, b;
a = Pn(2, Pwhite(-1.0, 1.0));
x = a.asStream;
8.do { x.next.postln };
)
