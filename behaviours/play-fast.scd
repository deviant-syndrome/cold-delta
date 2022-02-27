var playMovementFast = { | time |
	topEnvironment.use({
		~movement1Context.valueEnvir(exec: { | movement1Riffs |
			movement1Riffs[\tremolos].next(Event.new).play;
		});
	});

};

~playMovementFast = Dictionary.newFrom(
	[\onSet, playMovementFast],
	[\onBeat, {}], // todo: this should play synth part
);
