var playPedalTone = { | duration |
	{
        var xx;
		postln("hheheheh");
		xx = Synth.new(\hellhell);
		duration.wait;
		xx.set(\gate, 0);

        // ~unbecome.value();
	}.fork;
};

~playPedalTone = playPedalTone;
