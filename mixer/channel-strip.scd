~initChannelStrip = {

SynthDef(\channelGain, { | gains = 0.5, out = 0 |
	var gained = In.ar(out, 2) * gains;
	ReplaceOut.ar(out, gained)
}).add;

SynthDef(\masterLimiter, { | out = 0 |
	var limited = Limiter.ar(In.ar(out, 2), 0.5);
	ReplaceOut.ar(out, limited);
}).add;
};