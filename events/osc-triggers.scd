var qq;
Require("hithrob-handler.scd");

OSCdef.freeAll;

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
				OSCdef.newMatching(\drumTrack, qq, '/tr', s.addr, nil, [nil, nil, 777.0]);
		});
	}
);
