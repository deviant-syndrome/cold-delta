SynthDef(\throbListenLookAhead, { | in = 0 |
	var reset;
	var trackb,trackh,trackq,tempo;
	var source, beep;
	var slopeanalysis;
	var dynanalysis;
	var stopw;
	var ampw;

	source = In.ar(in, 1);

    ampw =
	Latch.kr(
		WAmp.kr(in: Normalizer.ar(in: source, level: 0.3, dur: 0.01), winSize: 1),
		Impulse.kr(1));

	#trackb,trackh,trackq,tempo = DrumTrack.kr(source, 0,
		kicksensitivity: 0.91,
		snaresensitivity: 0.8,
		debugmode: 2);

	slopeanalysis = Latch.kr(
		Clip.kr(Slope.kr(
			Slope.kr(in: Latch.kr(Timer.kr(trig: trackq),
			Impulse.kr(25)), mul: 1.0, add: 0.0)), -10, 10),
			Impulse.kr(2));

			stopw = Timer.kr(trig: Changed.kr(slopeanalysis));
			// Poll.kr(Changed.kr(slopeanalysis), stopw);

	SendTrig.kr(Changed.kr(slopeanalysis), id: 1, value: 488.0);

	// Poll.kr(Impulse.kr(2), ampw);


	SendTrig.kr(InRange.kr(in: ampw, lo: 0.068, hi: 0.092), 4, 112); // moderate
	SendTrig.kr(InRange.kr(in: ampw, lo: 0.093, hi: 2), 4, 113); // high
	SendTrig.kr(InRange.kr(in: ampw, lo: 0.0, hi: 0.071), 4, 114); // low

	// SendTrig.kr(InRange.kr(in: Slope.kr(in: ampw, mul: 1.0, add: 0.0), lo: 0, hi: 199.9), 0, 113.0);

}).add;
