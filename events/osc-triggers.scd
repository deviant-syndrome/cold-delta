var behaviourOnSetHandler;
var behaviourOnSpeedUpHandler;
var behaviourOnSpeedDownHandler;
var behaviourTurnAroundHandler;
var behaviourOnBeatHandler;

OSCdef.freeAll;

behaviourOnSetHandler = { | msg, time |
   ~behaviour[\onSet].value(time);
};

behaviourOnBeatHandler = { | msg |
   ~behaviour[\onBeat].value;
};

behaviourOnSpeedUpHandler = { | msg |
   ~behaviour[\onSpeedUp].value;
};

behaviourOnSpeedDownHandler = { | msg |
   ~behaviour[\onSpeedDown].value;
};

behaviourTurnAroundHandler = { | msg |
   ~behaviour[\onTurnAround].value;
};

currentEnvironment.use({
		~conventionsContext.valueEnvir(exec: {
                                       | const_THROB_SPARSE_SET,
			                             const_THROB_SET,
            			                 const_THROB_BEAT,
            							 const_THROB_SPEEDUP,
            							 const_THROB_SPEEDDOWN |

				OSCdef.newMatching(\basicOnSet, behaviourOnSetHandler, '/tr', s.addr, nil, [nil, nil, const_THROB_SET]);

                OSCdef.newMatching(\basicOnBeat, behaviourOnBeatHandler, '/tr', s.addr, nil, [nil, nil, const_THROB_BEAT]);

				OSCdef.newMatching(\sparseOnSet, { Synth.new(\kickDistorted); }, '/tr', s.addr, nil, [nil, nil, const_THROB_SPARSE_SET]);

                OSCdef.newMatching(\tempoTrackUp, behaviourOnSpeedUpHandler, '/tr', s.addr, nil, [nil, 0, const_THROB_SPEEDUP]);

                OSCdef.newMatching(\tempoTrackDown, behaviourOnSpeedDownHandler, '/tr', s.addr, nil, [nil, 0, const_THROB_SPEEDDOWN]);

                OSCdef.newMatching(\turnArounds, behaviourTurnAroundHandler, '/tr', s.addr, nil, [nil, 1, 488.0]);

		});
	}
);
