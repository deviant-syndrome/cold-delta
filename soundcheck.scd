(Require("bootstrap.scd");


~globalRouting[\chuggs][\vstInsert].value("/Library/Audio/Plug-Ins/VST3/NadIR.vst3", false);
~globalRouting[\chuggs][\vstInsert].value("/Library/Audio/Plug-Ins/VST3/Emissary.vst3", true);

// ~globalRouting[\throbe][\gain].set(\gains, 0.0);

~globalRouting[\throbe][\jack].value(\throbBlast);
~globalRouting[\throbe][\send].value(\throbListenHigh);
~globalRouting[\chuggs][\gain].set(\gains, 0.3);
~globalRouting[\chuggs][\gain].set(\pos, -1);

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

(
	~globalRouting[\chuggs][\gain].set(\gains, 0.35);
)
(
SynthDef(\sawpulse, { |out, freq = 440, gate = 0.5, plfofreq = 6, mw = 0, ffreq = 2000, rq = 0.3, freqlag = 0.05, amp = 1|
    var sig, plfo, fcurve;
    plfo = SinOsc.kr(plfofreq, mul:mw, add:1);
    freq = Lag.kr(freq, freqlag) * plfo;
    fcurve = EnvGen.kr(Env.adsr(0, 0.3, 0.1, 20), gate);
    fcurve = (fcurve - 1).madd(0.7, 1) * ffreq;
    sig = Mix.ar([Pulse.ar(freq, 0.9), Saw.ar(freq*1.007)]);
	Poll.kr(Impulse.kr(4), gate);
    sig = RLPF.ar(sig, fcurve, rq)
        * EnvGen.kr(Env.adsr(0.04, 0.2, 0.6, 0.1), gate, doneAction: Done.freeSelf)
        * amp;
    Out.ar(out, sig ! 2)
}).add;
)
p = PmonoArtic(\sawpulse, \dur, 0.2, \freq, Pwhite(1,8) * 100, \legato, Pwrand(#[0.5, 1.0], #[0.1, 0.9], inf) ).play;

p.stop;
