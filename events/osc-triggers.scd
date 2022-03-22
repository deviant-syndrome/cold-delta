var behaviourOnSetHandler;
var behaviourOnSpeedUpHandler;
var behaviourOnSpeedDownHandler;
var behaviourTurnAroundHandler;
var behaviourOnBeatHandler;
var behaviourDynamicsHandler;

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
   ~alterCymbalTexture.value;
   ~behaviour[\onTurnAround].value;
};

behaviourDynamicsHandler = { | dynType |
    switch(dynType,
        112, ~behaviour[\onModerateVolume].value,
        113, ~behaviour[\onHighVolume].value,
        114, ~behaviour[\onQuietVolume].value,
        { });

    switch(dynType,
        112, { postln("MODERATE!"); },
        113, { postln("INTENSE!"); },
        114, { postln("QUIET!");
        	topEnvironment.use({
                ~globalRouting[\throbe][\strip].set(\level, 0);
            });
         },§
        { });

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

				// OSCdef.newMatching(\sparseOnSet, { Synth.new(\kickDistorted); }, '/tr', s.addr, nil, [nil, nil, const_THROB_SPARSE_SET]);

                OSCdef.newMatching(\tempoTrackUp, behaviourOnSpeedUpHandler, '/tr', s.addr, nil, [nil, 0, const_THROB_SPEEDUP]);

                OSCdef.newMatching(\tempoTrackDown, behaviourOnSpeedDownHandler, '/tr', s.addr, nil, [nil, 0, const_THROB_SPEEDDOWN]);

                OSCdef.newMatching(\turnArounds, behaviourTurnAroundHandler, '/tr', s.addr, nil, [nil, 1, 488.0]);

                OSCdef.newMatching(\dynamics, { | msg | behaviourDynamicsHandler.value(msg[3]) }, '/tr', s.addr, nil, [nil, 4, nil]);

		});
	}
);
