var e = currentEnvironment;

var tick = { | time |
	~delta = time - ~prevTime;
    ~prevTime = time;
};

~prevTime = 0;
~delta = 0;

e[\stopWatchContext] = { | delta,
	                       exec
					     | exec.value(tick, delta); };
