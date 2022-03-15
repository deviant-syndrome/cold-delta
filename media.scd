var e = currentEnvironment;
var curDir = thisProcess.nowExecutingPath.dirname;

postln("heck???");
e.use({
	~configContext.valueEnvir(exec: { | config |
		e[\const_THROB_BUF] = Buffer.read(s, curDir +/+ config["media"]["drums.path"]);
	});
});


e[\mediaContext] = { | const_THROB_BUF,
	                   exec
					 | exec.value(const_THROB_BUF); };
