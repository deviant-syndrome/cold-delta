var e = currentEnvironment;

e[\const_HI_THROB] = 666.0;
e[\const_THROB_DROP] = 667.0;

e[\context] = { | const_HI_THROB,
			      const_THROB_DROP,
	exec | exec.value(
		          const_HI_THROB,
				  const_THROB_DROP); };
