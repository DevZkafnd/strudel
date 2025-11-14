// ============================================
// BEAT TRAP - Pattern Trap Modern
// ============================================
// Beat dengan karakteristik trap: hi-hat rolls, 808 kick, snare pada 3

s.waitForBoot({
	~bpm = 140;  // Trap biasanya 130-150 BPM
	~clock = TempoClock(~bpm/60);
	
	// ===== SYNTH DEFINISI =====
	// 808-style Kick (sub bass)
	SynthDef(\kick808, { |out=0, amp=1.0, freq=50|
		var env, pitchEnv, sig;
		env = EnvGen.ar(Env.perc(0.001, 0.6, 1, -6), doneAction:2);
		pitchEnv = EnvGen.ar(Env([1, 0.1], [0.05], 'exp'));
		sig = SinOsc.ar(freq * pitchEnv) * env * amp;
		sig = sig.tanh;  // Slight distortion
		Out.ar(out, sig ! 2);
	}).add;
	
	SynthDef(\snare, { |out=0, amp=0.8|
		var env, body, noise, sig;
		env = EnvGen.ar(Env.perc(0.001, 0.2, 1, -4), doneAction:2);
		body = SinOsc.ar(200) * EnvGen.ar(Env.perc(0.001, 0.08));
		noise = HPF.ar(WhiteNoise.ar(1.2), 7000);
		sig = (body * 0.3 + noise * 0.7) * env * amp;
		Out.ar(out, sig ! 2);
	}).add;
	
	// Hi-hat dengan variasi
	SynthDef(\hat, { |out=0, amp=0.4, freq=12000|
		var env, sig;
		env = EnvGen.ar(Env.perc(0.001, 0.05), doneAction:2);
		sig = HPF.ar(WhiteNoise.ar(1.0), freq) * env * amp;
		Out.ar(out, sig ! 2);
	}).add;
	
	// ===== PATTERN TRAP =====
	// Trap: Kick pada 1, 1.5, 3.5, Snare pada 3, Hi-hat rolls
	
	Pdef(\kick, Pbind(
		\instrument, \kick808,
		\dur, Pseq([1, 0.5, 1.5, 0.5, 1], inf),
		\freq, Pseq([50, 50, 45, 50], inf),  // Variasi pitch
		\amp, 1.0
	));
	
	Pdef(\snare, Pbind(
		\instrument, \snare,
		\dur, 2,
		\timingOffset, 2,  // Snare pada beat 3 (bukan 2 dan 4)
		\amp, 0.8
	));
	
	// Hi-hat dengan rolls (triplet pattern)
	Pdef(\hats, Pbind(
		\instrument, \hat,
		\dur, Pseq([0.25, 0.25, 0.5, 0.25, 0.25, 0.25, 0.25], inf),
		\amp, Pseq([0.3, 0.5, 0.2, 0.4, 0.5, 0.3, 0.4], inf),
		\freq, Pwhite(10000, 14000, inf)
	));
	
	s.sync;
	
	~start = {
		"🔥 Trap Beat dimulai!".postln;
		Pdef(\kick).play(~clock, quant:1);
		Pdef(\snare).play(~clock, quant:1);
		Pdef(\hats).play(~clock, quant:1);
	};
	
	~stop = { Pdef.all.do(_.stop) };
	
	~start.();
});

