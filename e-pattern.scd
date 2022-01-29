~getPattern = { | steps, pulses |
	var pattern = [];
	var counts = [];
	var remainders = [];
	var divisor = steps - pulses;
	var level = 0;
	var index = 0;
	var build = { |level|
		if (level == -1, {
			pattern = pattern.add(0);
		},
		{ if (level == -2, {
			pattern = pattern.add(1);
		}, {
			(0..counts[level] - 1).do({ | i |
				build.value(level - 1);
			});
			if (remainders[level] != 0, {
				build.value(level - 2);
			});
		}); });
	};

	remainders = remainders.add(pulses);
	while ( { remainders[level] > 1; }, {
		counts = counts.add((divisor / remainders[level]).floor);
		remainders = remainders.add(divisor % remainders[level]);
		divisor = remainders[level];
		level = level + 1;
	});
	counts = counts.add(divisor);
	build.value(level);

	postln(pattern);
};




