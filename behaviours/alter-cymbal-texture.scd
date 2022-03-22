// each time a turnaround hits, test the probability
// set the filter to one of the predefined values (weighted selection)
// set the ducking agressiveness to one of the predefined values
//

~alterCymbalTexture = {
	topEnvironment.use({

		var filterOptions = [8000, 10000, 13000];
		var duckingStrengthOptions = [1.0, 0.4, 0.6];

		// cymbal texture is a part of throbe group
		var alterTexture = {
			~globalRouting[\throbe][\strip].set(\cymbalFilter,
				filterOptions.wchoose([0.33, 0.33, 0.33].normalizeSum));
		};

		var alterDuckingStrengh = {
			~globalRouting[\throbe][\strip].set(\cymbalDucking,
				duckingStrengthOptions.wchoose([0.33, 0.33, 0.33].normalizeSum));
		};

		var muteCymbals = {
			~globalRouting[\throbe][\strip].set(\level, 0);
		};

		var doNothing = { /* noop */ };

		~globalRouting[\throbe][\strip].set(\level, 1);

		[alterTexture, doNothing].wchoose([0.8, 0.2]).value;
		[alterDuckingStrengh, doNothing].wchoose([0.8, 0.2]).value;
        [muteCymbals, doNothing].wchoose([0.6, 0.5]).value;
	});
};
