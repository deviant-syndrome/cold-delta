var routing, busses, mixer, masterStrip;

routing = Dictionary.newFrom([
	\throbe, Dictionary(),
	\cymbals, Dictionary(),
	\chuggs, Dictionary()
]);

busses = [];


routing.keys.do { arg item, i;
  	var bus = Bus.audio(s, 2);
    var strip = Group.tail(s);
	var gain = Synth.tail(strip, \channelGain, [\out, bus.index]);

	routing[item].put(\gain, gain);
	routing[item].put(\busNum, bus.index);
	routing[item].put(\jack, { arg v; Synth.head(strip, v, [\out, bus.index])});
	routing[item].put(\send, { arg v; Synth.before(gain, v, [\in, bus.index])});
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
