var behaviourOnSetHandler;

OSCdef.freeAll;

behaviourOnSetHandler = { | msg, time |
   ~behaviour[\onSet].value(time);
};

currentEnvironment.use({
		~context.valueEnvir(exec: {
			| const_HI_THROB |

				OSCdef.newMatching(\basicOnSet, behaviourOnSetHandler, '/tr', s.addr, nil, [nil, nil, const_HI_THROB]);

				// OSCdef.newMatching(\drumTrack, qq, '/tr', s.addr, nil, [nil, 0, 777.0]);

				// OSCdef.newMatching(\deee, { |msg| topEnvironment[\playPedalTone].value(msg[3]); postln(msg[3]); }, '/tr', s.addr, nil, [nil, 1, nil]);

				OSCdef.newMatching(\tempoTrackUp, { postln("speed up!"); topEnvironment[\become].value(topEnvironment[\playMovementFast]); )}, '/tr', s.addr, nil, [nil, 0, 778.0]);
				OSCdef.newMatching(\tempoTrackDown, { postln("speed down!"); topEnvironment[\unbecome].value; )}, '/tr', s.addr, nil, [nil, 0, 779.0]);

		});
	}
);
