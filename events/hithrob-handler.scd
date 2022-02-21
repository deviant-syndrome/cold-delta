// todo: add generated euclidian pattern here
~cymbals = Pbind(
    \intrument, \default,
    \dur, 0.1,
	\amp, 0.2).asStream;

// todo: maybe gather all the pulses into one list/dictionary
~pulse4of4 = Routine.new({ true.yield; false.yield; false.yield; false.yieldAndReset; });

~hiThrobHandler = {
	var pulse = ~pulse4of4.next();
	if (pulse, { ~cymbals.next(Event.new).play; });
}
