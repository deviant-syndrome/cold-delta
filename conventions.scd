var e = currentEnvironment;

e[\const_HI_THROB] = 666.0;

e[\context] = { | const_HI_THROB, exec | exec.value(const_HI_THROB); };
