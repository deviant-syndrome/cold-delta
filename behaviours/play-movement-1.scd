var playMovement1 = { | time |
	var strokeGate, pulse, release, pm;

	topEnvironment.use({
		~stopWatchContext.valueEnvir(exec: { | tick, delta |
			tick.value(time);
			// todo: add mean values from window here instead of hardcoding
			if (delta > 0.1392378519995, { strokeGate = false; }, { strokeGate = true; });
			if (delta > 0.192378519995, { release = 1 }, { release = 0.01; });

		});
	});

	topEnvironment.use({
		~movement1Context.valueEnvir(exec: { | movement1Riffs, movement1Sync |
			if (movement1Sync.next(), { movement1Riffs[\chops].next((strokeGate: strokeGate, release: release)).play; });
		});
	});

};

// ~playMovement1 = Dictionary.newFrom(
// 	[\begin, {
// 			// set the distorted kicks level based on weighted randomness
// 		} ],
// 	[\onSet, playMovement1],
// 	[\onBeat, {}],
// 	[\onSpeedUp, { topEnvironment[\become].value(topEnvironment[\playMovementFast]); } ],
//     [\onSpeedDown, { topEnvironment[\unbecome].value; } ],
// 	[\onTurnAround, {}]
// );

var prob = Pwrand.new([{}, { topEnvironment[\become].value(topEnvironment[\playLeaks]); }], [0.5, 0.5].normalizeSum, inf).asStream;

~playMovement1 = Dictionary.newFrom(
	[
	  \begin, { /* set the distorted kicks level based on weighted randomness */ },
      \onSet, playMovement1,
	  \onBeat, {},
	  \onSpeedUp, { topEnvironment[\become].value(topEnvironment[\playMovementFast]); },
	  \onTurnAround, {
		 // topEnvironment[\become].value(topEnvironment[\playLeaks]);
		 postln(prob.next);
		 prob.next.value;
	  }
    ]
);
