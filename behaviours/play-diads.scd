var playDiads = { | time |
	topEnvironment.use({
		~diadsContext.valueEnvir(exec: { | string5, string6 |
			string5.next(Event.new).play;
			string6.next(Event.new).play;
		});
	});

};

var playKeys = { | time |
	topEnvironment.use({
		~diadsContext.valueEnvir(exec: { | string5, string6, keys |
			keys.next(Event.new).play;
		});
	});

};

~playDiads = Dictionary.newFrom(
	[
	  \onTurnAround, playDiads,
	  \onBeat, playKeys
	]
);
