s.waitForBoot({

    // ========================
    // Synth Definisi
    // ========================

    // Bass dreamy
    SynthDef(\dreamBass, { |freq=55, amp=0.3|
        var env, sig;
        env = EnvGen.kr(Env.asr(2, 1, 4), doneAction:2); // fade in/out lembut
        sig = SinOsc.ar(freq, 0, amp); // sinus bass
        sig = LPF.ar(sig, 200); // lowpass biar hangat
        sig = sig * env;
        Out.ar(0, sig.dup);
    }).add;

    // Gitar pad dreamy
    SynthDef(\dreamGuitar, { |freq=220, amp=0.2, pan=0|
        var env, sig;
        env = EnvGen.kr(Env.asr(3, 1, 6), doneAction:2);
        sig = Saw.ar(freq, amp) + Pulse.ar(freq*2, 0.4, amp*0.5);
        sig = BPF.ar(sig, freq*2, 0.2); // filter untuk dapet timbre airy
        sig = FreeVerb.ar(sig, 0.6, 0.8, 0.3); // reverb luas
        sig = Pan2.ar(sig * env, pan);
        Out.ar(0, sig);
    }).add;

    // ========================
    // Pattern Musik
    // ========================

    // Bass pattern pelan, dreamy
    Pbind(
        \instrument, \dreamBass,
        \freq, Pseq([55, 55, 55, 60, 60, 55], inf), // ala root bass line
        \dur, 2, // lambat
        \amp, 0.3
    ).play;

    // Gitar ambient pad
    Pbind(
        \instrument, \dreamGuitar,
        \freq, Pseq([220, 330, 440, 330], inf), // chord-like line
        \dur, Pwhite(4, 6, inf), // sustain lama
        \amp, 0.25,
        \pan, Pwhite(-0.5, 0.5, inf) // random stereo spread
    ).play;
});
