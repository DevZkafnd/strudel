// ============================================
// BEAT BASIC - Template Sederhana untuk Beat
// ============================================
// File ini adalah template dasar untuk membuat beat di SuperCollider
// Cocok untuk pemula yang ingin belajar membuat beat

s.waitForBoot({
	// ===== SETUP TEMPO =====
	~bpm = 120;  // Ubah BPM sesuai keinginan (60-180)
	~clock = TempoClock(~bpm/60);
	
	"🎵 Beat Basic Template - BPM: ".post; ~bpm.postln;
	
	// ===== DEFINISI SYNTH DRUM =====
	
	// Kick Drum (Bass Drum)
	SynthDef(\kick, { |out=0, amp=0.8, freq=50|
		var env, pitchEnv, sig, click;
		env = EnvGen.ar(Env.perc(0.001, 0.3, 1, -4), doneAction:2);
		pitchEnv = EnvGen.ar(Env([1, 0.3], [0.01], 'exp'));
		click = HPF.ar(WhiteNoise.ar(0.1), 5000) * EnvGen.ar(Env.perc(0.001, 0.01));
		sig = SinOsc.ar(freq * pitchEnv) + click;
		sig = sig * env * amp;
		Out.ar(out, sig ! 2);
	}).add;
	
	// Snare Drum
	SynthDef(\snare, { |out=0, amp=0.6|
		var env, body, noise, sig;
		env = EnvGen.ar(Env.perc(0.001, 0.2, 1, -4), doneAction:2);
		body = SinOsc.ar(180) * EnvGen.ar(Env.perc(0.001, 0.05));
		noise = HPF.ar(WhiteNoise.ar(0.8), 5000);
		sig = (body * 0.3 + noise * 0.7) * env * amp;
		Out.ar(out, sig ! 2);
	}).add;
	
	// Hi-Hat (Closed)
	SynthDef(\hat, { |out=0, amp=0.4|
		var env, sig;
		env = EnvGen.ar(Env.perc(0.001, 0.05), doneAction:2);
		sig = HPF.ar(WhiteNoise.ar(1.0), 10000) * env * amp;
		Out.ar(out, sig ! 2);
	}).add;
	
	// Open Hi-Hat
	SynthDef(\oh, { |out=0, amp=0.3|
		var env, sig;
		env = EnvGen.ar(Env.perc(0.001, 0.3), doneAction:2);
		sig = BPF.ar(WhiteNoise.ar(1.0), 8000, 0.5) * env * amp;
		Out.ar(out, sig ! 2);
	}).add;
	
	// Clap
	SynthDef(\clap, { |out=0, amp=0.5|
		var env, sig;
		env = EnvGen.ar(Env.perc(0.001, 0.15), doneAction:2);
		sig = WhiteNoise.ar(0.6) * env * amp;
		sig = BPF.ar(sig, 2000, 0.3);
		Out.ar(out, sig ! 2);
	}).add;
	
	// ===== PATTERN BEAT =====
	// Pattern dasar: Kick pada 1, Snare pada 2 dan 4, Hi-hat setiap 1/4
	
	Pdef(\kick, Pbind(
		\instrument, \kick,
		\dur, 1,  // Setiap 1 beat (quarter note)
		\amp, 0.8
	));
	
	Pdef(\snare, Pbind(
		\instrument, \snare,
		\dur, 2,  // Setiap 2 beat (half note)
		\timingOffset, 1,  // Offset 1 beat (jadi pada beat 2 dan 4)
		\amp, 0.6
	));
	
	Pdef(\hats, Pbind(
		\instrument, \hat,
		\dur, 0.5,  // Setiap 0.5 beat (eighth note)
		\amp, Pwhite(0.3, 0.5, inf)  // Variasi volume
	));
	
	// Tunggu synth siap
	s.sync;
	
	// ===== FUNGSI KONTROL =====
	~start = {
		"▶️ Beat dimulai!".postln;
		Pdef(\kick).play(~clock, quant:1);
		Pdef(\snare).play(~clock, quant:1);
		Pdef(\hats).play(~clock, quant:1);
	};
	
	~stop = {
		"⏹️ Beat dihentikan!".postln;
		Pdef.all.do(_.stop);
	};
	
	// Auto-start
	~start.();
	
	// ===== INSTRUKSI =====
	"".postln;
	"📝 KONTROL:".postln;
	"~start.();  // Mulai beat".postln;
	"~stop.();   // Hentikan beat".postln;
	"~bpm = 128; // Ubah tempo (lalu restart)".postln;
	"".postln;
});

