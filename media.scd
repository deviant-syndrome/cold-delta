var e = currentEnvironment;
var curDir = thisProcess.nowExecutingPath.dirname;

e[\const_THROB_BUF] = Buffer.read(s, curDir +/+ "media/drums.wav");

e[\mediaContext] = { | const_THROB_BUF,
	                   exec
					 | exec.value(const_THROB_BUF); };
