// todo: rewrite with contexts instead
// todo: throb lookahead
~globalRouting[\throbe][\jack].value(\throbBlast);
~globalRouting[\throbe][\send].value(\throbListenHigh);

// ~globalRouting[\throbe][\gain].set(\gains, 0.0); // debug

~globalRouting[\throbLookAhead][\jack].value(\throbBlast, [\offsetSeconds, 5]);
~globalRouting[\throbLookAhead][\send].value(\throbListenLookAhead);
~globalRouting[\throbLookAhead][\gain].set(\gains, 0.0);


~globalRouting[\chuggs][\gain].set(\gains, 0.3);
~globalRouting[\chuggs][\gain].set(\pos, -1);

// ~globalRouting[\chuggs][\vstInsert].value("/Library/Audio/Plug-Ins/VST3/NadIR.vst3", false);
// ~globalRouting[\chuggs][\vstInsert].value("/Library/Audio/Plug-Ins/VST3/Emissary.vst3", false);

~globalRouting[\synth1][\send].value(\delayLine);
