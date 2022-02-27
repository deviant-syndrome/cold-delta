var qq;
Require("hithrob-handler.scd");

OSCdef.freeAll;

// todo: cleanup
qq = {
	topEnvironment.use({
		~riffsContext.valueEnvir(exec: { | basicRiffs |

			basicRiffs[\bells].next(Event.new).play;

			//basicRiffs[\chuggs].next((strokeGate: strokeGate, release: release)).play;
		});
	});

};

currentEnvironment.use({
		~context.valueEnvir(exec: {
			| const_HI_THROB |
				OSCdef.newMatching(\basic, ~hiThrobHandler, '/tr', s.addr, nil, [nil, nil, const_HI_THROB]);
				OSCdef.newMatching(\drumTrack, {}, '/tr', s.addr, nil, [nil, nil, 777.0]);
				OSCdef.newMatching(\tempoTrack, { postln("spped up!"; topEnvironment[\become].value(topEnvironment[\playMovementFast]); )}, '/tr', s.addr, nil, [nil, nil, 778.0]);
				OSCdef.newMatching(\tempoTrack2, { postln("spped down!"; topEnvironment[\unbecome].value; )}, '/tr', s.addr, nil, [nil, nil, 779.0]);

		});
	}
);
