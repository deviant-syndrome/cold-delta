var e = currentEnvironment;

e[\const_THROB_SPARSE_SET] = 665.0;
e[\const_THROB_SET]        = 666.0;
e[\const_THROB_BEAT]       = 667.0;
e[\const_THROB_SPEEDUP]    = 778.0;
e[\const_THROB_SPEEDDOWN]  = 779.0;

e[\conventionsContext] = { |
							 const_THROB_SPARSE_SET,
							 const_THROB_SET,
			                 const_THROB_BEAT,
							 const_THROB_SPEEDUP,
							 const_THROB_SPEEDDOWN
	exec | exec.value(
						const_THROB_SPARSE_SET,
						const_THROB_SET,
						const_THROB_BEAT,
						const_THROB_SPEEDUP,
						const_THROB_SPEEDDOWN); };
