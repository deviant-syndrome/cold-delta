var playMovementFast = { | time |
	topEnvironment.use({
		~movement1Context.valueEnvir(exec: { | movement1Riffs |
			movement1Riffs[\tremolos].next(Event.new).play;
		});
	});

};

~playMovementFast = Dictionary.newFrom(
	[
	  \onSet, playMovementFast,
	  \onSpeedDown, { topEnvironment[\unbecome].value; }
	]
);
