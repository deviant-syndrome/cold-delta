~randomPartialPickerProto = { | data, numPartials, stretch = false |
	var count = data.size.div(3);
	var randomDataFragment = Array.newClear(numPartials * 3);
	var longest = 0;
	numPartials.do({ arg index;
		var partialNum = count.rand();
		var duration = data[partialNum * 3].sum;

		if (length > duration, { longest = duration });

		randomDataFragment[index * 3] = data[partialNum * 3];
		randomDataFragment[index * 3 + 1] = data[partialNum * 3 + 1];
		randomDataFragment[index * 3 + 2] = data[partialNum * 3 + 2];

	});
	// stretch partials to the size of longest one
	numPartials.do({ arg index;
		randomDataFragment[index * 3] = randomDataFragment[index * 3].normalize(0, longest);
	});
    randomDataFragment;
};

~randomPartialPicker = { | numPartials | ~randomPartialPickerProto.value(_, numPartials); }


// partials crossfade from one to another
//
//
