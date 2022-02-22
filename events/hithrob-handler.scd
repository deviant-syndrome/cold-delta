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
    \stroke, Pgate(Pseq([0, 1], inf), inf, \strokeGate),
    \out, ~globalRouting[\chuggs][\busNum]
    ).asStream;

// ~picking = Pbind(
//     \dur, 0.35,
//     \amp, 0.2,
//     // todo: detect fast beats and switch to alternate picking
//     \stroke, Pgate(Pseq([0, 1], inf), inf, \strokeGate),
//     \verbose, Pfunc({ |ev| postln(ev )})
//     ).asStream;
//

// todo: maybe gather all the pulses into one list/dictionary
~pulse4of4 = Routine.new({ true.yield; false.yield; false.yield; false.yieldAndReset; });

~prevTime = 0;
~delta = 0;

~hiThrobHandler = { | msg, time |
    var strokeGate, pulse;
     // postln(~delta);

    ~delta = time - ~prevTime;
    ~prevTime = time;

    // 0.1392378519995

    if (~delta > 0.1392378519995, { strokeGate = false; }, { strokeGate = true; });

    // postln(strokeGate);
     // ~picking.next((strokeGate: strokeGate)).play;

    pulse = ~pulse4of4.next();
	if (pulse, { ~cymbals.next(Event.new).play; });
    ~chuggs.next((strokeGate: strokeGate)).play;
}
