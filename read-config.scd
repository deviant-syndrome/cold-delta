var e = currentEnvironment;
var curDir = thisProcess.nowExecutingPath.dirname;
var config = (curDir +/+ "config.yml").parseYAMLFile;

e[\configContext] = {|
	                   exec
					 | exec.value(config); };
