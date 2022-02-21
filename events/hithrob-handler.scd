// todo: add generated euclidian pattern here
Require("../e-pattern.scd");
Require("../pat-utils.scd");

~cymbals = Pbind(
    \instrument, \splash,
    \dur, ~loopForever.value({ |i| ~pat8ths.value(~getPattern.value(8 - i, 3)); }),
	\pan, Pwrand.new([-0.4, -0.7, 0.6], [1, 3, 5].normalizeSum, inf),
	\amp, 0.1).asStream;

// todo: maybe gather all the pulses into one list/dictionary
~pulse4of4 = Routine.new({ true.yield; false.yield; false.yield; false.yieldAndReset; });

~hiThrobHandler = {
	var pulse = ~pulse4of4.next();
	if (pulse, { ~cymbals.next(Event.new).play; });
}
