(
b = d
)

(
~stutter = { |snd, reset, fragmentlength, rate = 1.0, maxdelay = 10|
    var phase, fragment, del;
    phase = Sweep.ar(reset);
    fragment = { |ph| (ph - Delay1.ar(ph)) < 0 + Impulse.ar(0) }.value(phase / fragmentlength % 1);
    del = Latch.ar(phase, fragment) + ((fragmentlength - Sweep.ar(fragment)) * (rate - 1));
    DelayC.ar(snd, maxdelay, del);
};
)

(
c = SynthDef(\blast, { | freeze = 0 |
	var snd, reset;
		var buf = LocalBuf(44100 * 0.5, 1);

	snd = PlayBuf.ar(1, b, BufRateScale.kr(b), loop: 1);
	reset = Onsets.kr(FFT(LocalBuf(512), snd), 0.7);
	   // SendTrig.kr(reset, 0, 666);
	// snd = ~stutter.(snd, reset, 0.09);
	BufWr.ar(snd, buf, Phasor.ar(reset, 1, 0, BufFrames.kr(buf)));

	snd = DelayC.ar(snd, 0.2, 0.2);

	snd = Select.ar(freeze, [snd, PlayBuf.ar(1, buf, BufRateScale.kr(buf), loop: 1)]);
	Out.ar(0, snd!2 * 0.25);
}).play;

)

(
c.free;
)
(
c.set(\freeze, 1)
)

(
{	var snd, reset;


	snd = PlayBuf.ar(1, b, BufRateScale.kr(b), loop: 1);
        reset = Onsets.kr(FFT(LocalBuf(512), snd), 0.7);
	    SendTrig.kr(reset, 0, 666);
        snd = ~stutter.(snd, reset, 0.09);
        snd = DelayC.ar(snd, 0.2, 0.2);
        snd!2 * 0.35;
}.play;
)

(
Scale.names
)

(
~myPattern = Pbind(
    \intrument, \default,
    \dur, 0.1,
	\scale, Scale.diminished,
	\degree, Pseq([0, 1, 2, 3, 2], inf),
    \amp, 0.2
).asStream;

)



(
o = OSCFunc({ arg msg, time;
	~myPattern.next(Event.new).play
	// [time, msg].postln;
},'/tr', s.addr);
)

(
o.free;
)
