var playMovement1 = { | time |

	var strokeGate, pulse, release, pm;


	topEnvironment.use({
		~stopWatchContext.valueEnvir(exec: { | tick, delta |
			tick.value(time);
			// todo: add mean values from window here instead of hardcoding
			if (delta > 0.1392378519995, { strokeGate = false; }, { strokeGate = true; });
			if (delta > 0.192378519995, { release = 1 }, { release = 0.01; });
			// postln(release);

		});
	});

	topEnvironment.use({
		~movement1Context.valueEnvir(exec: { | movement1Riffs |
			movement1Riffs[\chops].next((strokeGate: strokeGate, release: release)).play;
		});
	});

};

~playMovement1 = Dictionary.newFrom(
	[\onSet, playMovement1],
	[\onBeat, {}], // todo: this should play synth part
);
