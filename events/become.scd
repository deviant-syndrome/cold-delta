// todo: add ability to partly inherit behaviours?
~become = { | beh |
	Environment.make {
	    ~behaviour = beh;
	}.push;
	postln(Environment.stack.size)
};

~unbecome = {
	if (Environment.stack.size > 1, { Environment.pop; })
};
