Require("hithrob-handler.scd");

OSCdef.freeAll;

currentEnvironment.use({
		~context.valueEnvir(exec: {
			| const_HI_THROB |
				OSCdef.newMatching(\basic, ~hiThrobHandler, '/tr', s.addr, nil, [nil, nil, const_HI_THROB]);
		});
	}
);
