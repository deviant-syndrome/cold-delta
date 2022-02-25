var routing, busses, mixer, masterStrip;

routing = Dictionary.newFrom([
	\throbe, Dictionary(),
	\cymbals, Dictionary(),
	\chuggs, Dictionary(),
	\partials, Dictionary(),
	\synth1, Dictionary(),
	\throbLookAhead, Dictionary()
]);

busses = [];


routing.keys.do { arg item, i;
  	var bus = Bus.audio(s, 2);
    var strip = Group.tail(s);
	var gain = Synth.tail(strip, \channelGain, [\out, bus.index]);

	routing[item].put(\gain, gain);
	routing[item].put(\busNum, bus.index);
	routing[item].put(\jack, { arg v; Synth.head(strip, v, [\out, bus.index])});
	// todo: try using a Monitor here
	routing[item].put(\send, { arg v, params; Synth.before(gain, v, [\in, bus.index] ++ params)});
	routing[item].put(\strip, strip);
	routing[item].put(\vstInsert, {
		arg vstFileName, showGui = false;
		var vst = VSTPluginController(Synth.head(strip, \insert, [\bus, bus.index]));
		vst.open(vstFileName, verbose: true);
		if (showGui, { vst.gui; });
	});

	busses = busses.add(bus.index);
};


masterStrip = Group.tail(s);

Synth.tail(masterStrip, \masterLimiter);

SynthDef(\mixer, {
		Out.ar(0, Mix.fill(routing.keys.size, { arg i;
			var busNum = busses[i];

			In.ar(busNum, 2);
		}));
}).play(masterStrip, addAction: \addToHead);


~globalRouting = routing;
