// todo: add generated euclidian pattern here
Require("../e-pattern.scd");
Require("../pat-utils.scd");

~cymbals = Pbind(
    \instrument, \splash,
    \dur, ~loopForever.value({ |i| ~pat8ths.value(~getPattern.value(8 - i, 3)); }),
    \group, ~globalRouting[\cymbals][\strip],
	\pan, Pwrand.new([-0.4, -0.7, 0.6], [1, 3, 5].normalizeSum, inf),
	\amp, 0.2,
    \out, ~globalRouting[\cymbals][\busNum]).asStream;

~chuggs = Pbind(
    \instrument, \steelString,
    \group, ~globalRouting[\chuggs][\strip],
    \dur, 0.35,
    \amp, 0.2,
    // todo: detect fast beats and switch to alternate picking
    \stroke, Pseq([0, 0], inf),
    \out, ~globalRouting[\chuggs][\busNum]
    ).asStream;


// todo: maybe gather all the pulses into one list/dictionary
~pulse4of4 = Routine.new({ true.yield; false.yield; false.yield; false.yieldAndReset; });

~hiThrobHandler = {
	var pulse = ~pulse4of4.next();
	if (pulse, { ~cymbals.next(Event.new).play; });
    ~chuggs.next(Event.new).play;
}
