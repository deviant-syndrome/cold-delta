var qq, hell;
Require("hithrob-handler.scd");

OSCdef.freeAll;

hell = Pbind(
	\instrument, \hellhell,
	\dur, Pseq([1 / 2, 1 / 2, 1 / 2, 0.5 / 2], inf),
	\release, Pseq([0.4 , 0.1, 0.1, 0.2], inf),
	\p1, Pseq([5, 5, 1, 2], inf),
	\amp, 0.06
).asStream;

// todo: cleanup
qq = {
	hell.next(Event.new).play;
	// topEnvironment.use({
	// 	~riffsContext.valueEnvir(exec: { | basicRiffs |
	//
	// 		basicRiffs[\bells].next(Event.new).play;
	//
	// 		//basicRiffs[\chuggs].next((strokeGate: strokeGate, release: release)).play;
	// 	});
	// });

};

currentEnvironment.use({
		~context.valueEnvir(exec: {
			| const_HI_THROB |

				OSCdef.newMatching(\basic, ~hiThrobHandler, '/tr', s.addr, nil, [nil, nil, const_HI_THROB]);

				OSCdef.newMatching(\drumTrack, qq, '/tr', s.addr, nil, [nil, 0, 777.0]);

				// OSCdef.newMatching(\deee, { |msg| topEnvironment[\playPedalTone].value(msg[3]); postln(msg[3]); }, '/tr', s.addr, nil, [nil, 1, nil]);

				OSCdef.newMatching(\tempoTrack, { postln("spped up!"; topEnvironment[\become].value(topEnvironment[\playMovementFast]); )}, '/tr', s.addr, nil, [nil, 0, 778.0]);
				OSCdef.newMatching(\tempoTrack2, { postln("spped down!"; topEnvironment[\unbecome].value; )}, '/tr', s.addr, nil, [nil, 0, 779.0]);

		});
	}
);
