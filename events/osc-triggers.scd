Require("hithrob-handler.scd");

OSCdef.freeAll;

currentEnvironment.use({
		~context.valueEnvir(exec: {
			| const_HI_THROB |
				postln(const_HI_THROB);
				OSCdef.newMatching(\basic, { |msg, time, addr, recvPort| postln(msg); }, '/tr', s.addr, nil, [nil, nil, const_HI_THROB]);
		});
	}
);
