var playLeaks = {
	topEnvironment.use({
		~leaksContext.valueEnvir(exec: { | leaks |
			leaks.next(Event.new).play;
		});
	});
};

~playLeaks = Dictionary.newFrom(
	[
	  \onSet, playLeaks,
	  \onTurnAround, { topEnvironment[\unbecome].value; }
	]
);
