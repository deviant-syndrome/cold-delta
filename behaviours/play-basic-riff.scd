var pulse4of4 = Routine.new({ true.yield; false.yield; false.yield; false.yieldAndReset; });

var playBasicRiff = { | time |

	var strokeGate, pulse, release;

	topEnvironment.use({
		~stopWatchContext.valueEnvir(exec: { | tick, delta |
			tick.value(time);
			// todo: add mean values from window here instead of hardcoding
			if (delta > 0.1392378519995, { strokeGate = false; }, { strokeGate = true; });
			if (delta > 0.192378519995, { release = 1 }, { release = 0.02; });

		});
	});

	topEnvironment.use({
		~riffsContext.valueEnvir(exec: { | basicRiffs |
			pulse = pulse4of4.next();
		
			if (pulse, { basicRiffs[\cymbals].next(Event.new).play; });
			if (pulse, { basicRiffs[\bowed].next(Event.new).play; });
			//basicRiffs[\chuggs].next((strokeGate: strokeGate, release: release)).play;
		});
	});

};

~playBasicRiff = Dictionary.newFrom(
	[\onTick, playBasicRiff]
);
