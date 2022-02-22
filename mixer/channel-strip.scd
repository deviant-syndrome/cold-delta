SynthDef(\channelGain, { | gains = 0.5, pos = 0, out = 0 |
	var gained = In.ar(out, 1) * gains;
	var panned = Pan2.ar(gained, pos);
	ReplaceOut.ar(out, panned)
}).add;

SynthDef(\masterLimiter, { | out = 0 |
	var limited = Limiter.ar(In.ar(out, 2), 0.5);
	ReplaceOut.ar(out, limited);
}).add;

SynthDef(\insert, { arg bus;
	ReplaceOut.ar(bus, VSTPlugin.ar(In.ar(bus, 2), 2));
}).add;

// design:
// Model after API 500 EQ https://www.apiaudio.com/product_specs.php?id=107s

/*
Number of Bands:	Four
Filter Type:	"Low" and "High" bands are Peak/Shelf switchable.
Low-Mid and Mid-High are peaking type
Filter Frequency Centers:	Low: 30, 40, 50, 100, 200, 300, 400Hz
Low-Mid: 75, 150, 180, 240, 500, 700, 1Khz
Mid-High: 800, 1.5K, 3K, 5K, 8K, 10K, 12.5K
High: 2.5K, 5K, 7K, 10K, 12.5K, 15K, 20K

*/
// low shelf
// mid boost
// high shelf

// Q is proportial to the boost
SynthDef(\channelEQ, { | out = 0, lshelf = 0, mids = 0, hshelf = 0 |
	var lowShelved = BPeakEQ.ar(In.ar(out, 2), 200, lshelf);

}).add;
