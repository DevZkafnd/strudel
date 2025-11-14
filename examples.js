// 🎵 Strudel Examples - Kumpulan Pattern dan Teknik Musik

// ===== MELODI DASAR =====
export const basicMelodies = {
    // Scale C major
    cMajorScale: 'note("c d e f g a b c5", "0.5")',
    
    // Arpeggio C major
    cMajorArpeggio: 'note("c e g c5", "0.5")',
    
    // Melodi sederhana
    simpleMelody: 'note("c4 d4 e4 f4 g4", "1 0.5 0.5 1 2")',
    
    // Melodi dengan rest
    melodyWithRest: 'note("c4 ~ d4 e4 ~ f4 g4", "0.5")',
    
    // Melodi dengan octave
    octaveMelody: 'note("c3 c4 c5", "1")'
};

// ===== DRUM PATTERNS =====
export const drumPatterns = {
    // Basic 4/4 beat
    basicBeat: `stack(
  s("bd*4"),
  s("~ sn ~ sn"),
  s("hh*8")
)`,
    
    // Funk pattern
    funkBeat: `stack(
  s("bd ~ ~ bd ~ ~ bd ~"),
  s("~ ~ sn ~ ~ ~ sn ~"),
  s("hh*8")
)`,
    
    // Hip-hop beat
    hipHopBeat: `stack(
  s("bd bd ~ ~ bd ~ ~ ~"),
  s("~ ~ sn ~ ~ ~ sn ~"),
  s("hh*8")
)`,
    
    // Breakbeat
    breakBeat: `stack(
  s("bd ~ ~ bd ~ ~ ~ bd"),
  s("~ ~ sn ~ ~ sn ~ ~"),
  s("hh*8")
)`
};

// ===== CHORD PROGRESSIONS =====
export const chordProgressions = {
    // Pop progression (I-V-vi-IV)
    popProgression: 'chord("c g am f", "2")',
    
    // Jazz progression (ii-V-I)
    jazzProgression: 'chord("dm7 g7 cmaj7", "2")',
    
    // Blues progression
    bluesProgression: 'chord("c f c g f c", "1")',
    
    // Minor progression
    minorProgression: 'chord("am dm g c", "2")'
};

// ===== BASS LINES =====
export const bassLines = {
    // Walking bass
    walkingBass: 'note("c2 d2 e2 f2 g2 a2 b2 c3", "0.5")',
    
    // Root notes
    rootNotes: 'note("c2 f2 g2 c2", "2")',
    
    // Bass with octave
    bassOctave: 'note("c2 c3 c2 c3", "1")'
};

// ===== EFEK DAN MODIFIKASI =====
export const effects = {
    // Reverb
    withReverb: 'note("c4 d4 e4 f4", "0.5").reverb(0.8)',
    
    // Delay
    withDelay: 'note("c4 d4 e4 f4", "0.5").delay(0.5, 0.3)',
    
    // Gain/Volume
    withGain: 'note("c4 d4 e4 f4", "0.5").gain(0.4)',
    
    // Pan
    withPan: 'note("c4 d4 e4 f4", "0.5").pan("0 0.5 -0.5 0")',
    
    // Speed/Tempo
    withSpeed: 'note("c4 d4 e4 f4", "0.5").speed(2)'
};

// ===== PATTERN KOMPLEKS =====
export const complexPatterns = {
    // Full song structure
    fullSong: `stack(
  note("c4 e4 g4", "2").gain(0.4).reverb(0.3),
  note("c2", "1").gain(0.6),
  s("bd*2 ~ sn ~ bd*2"),
  note("c4 d4 e4 f4 g4 a4 b4 c5", "0.5").gain(0.3).delay(0.3, 0.2)
)`,
    
    // Layered melody
    layeredMelody: `stack(
  note("c4 e4 g4 c5", "1").gain(0.5),
  note("c4 d4 e4 f4 g4 a4 b4 c5", "0.5").gain(0.3).reverb(0.4),
  note("c3 g3 c4", "2").gain(0.4)
)`,
    
    // Rhythm variation
    rhythmVariation: `stack(
  note("c4", "0.25").gain(0.6),
  note("e4", "0.5").gain(0.4),
  note("g4", "1").gain(0.5),
  s("bd ~ sn ~ bd ~ sn ~")
)`
};

// ===== DJ LOOP (HOUSE/TECHNO) =====
export const djLoops = {
    house124: `
setBPM(124);
stack(
  // core drums
  s("bd*4").gain(0.9),
  s("~ cp ~ cp").gain(0.55),
  s("hh*12").gain(0.16),
  s("~ ~ oh ~ ~ ~ oh ~").gain(0.22),
  // bass with pseudo sidechain (duck on offbeats)
  note("c2 ~ c2 ~", "0.5").gain(0.38),
  note("~ ~ ~ ~", "0.5").gain(0).shape(0.9),
  // chord stab, reverb and mild delay
  note("~ e4g4b4 ~ e4g4b4", "0.5").gain(0.22).reverb(0.35).delay(0.25, 0.2),
  // master soft limiter feel
  s("~").gain(0).tanh(0.9)
)
`.trim(),

    techno128: `
setBPM(128);
stack(
  s("bd*4").gain(0.92),
  s("hh*16").gain(0.17),
  s("~ ~ sn ~ ~ ~ sn ~").gain(0.6),
  // rolling bass with filter movement
  note("c2 c2 ~ c2", "0.5").gain(0.36).lowpass(500),
  note("c2 c2 ~ c2", "0.5").gain(0.12).highpass(200),
  // airy stab / pad ticks
  note("~ ~ g4 ~ ~ ~ g4 ~", "0.5").gain(0.2).reverb(0.35).delay(0.125, 0.15)
)
`.trim()
};

// ===== CHILL LOOP =====
export const chillLoops = {
    chill90: `
setBPM(90);
stack(
  // soft drums
  s("bd ~ bd ~").gain(0.6),
  s("~ cp ~ ~").gain(0.3),
  s("hh*8").gain(0.1),
  // mellow bass
  note("c2 ~ g1 ~", "1").gain(0.35).lowpass(450),
  // warm pad
  note("c4e4g4 ~ a3e4a4 ~", "2").gain(0.22).reverb(0.5).delay(0.375, 0.25),
  // lead sprinkles
  note("~ d5 ~ ~ g4 ~ ~ ~", "0.5").gain(0.16).reverb(0.4)
)
`.trim()
};

// ===== GUITAR THEME (Pirates-like, minor key, driving feel) =====
export const guitarThemes = {
    piratesMinor: `
setBPM(132);
stack(
  // brisk percussion for drive
  s("bd*4").gain(0.6),
  s("~ cp ~ cp").gain(0.35),
  s("hh*12").gain(0.12),
  // ostinato guitar arpeggio (a minor flavor)
  note("a3 e4 a4 c5 e5 a5 a4 e5 c5 a4 e4 a3", "0.25").gain(0.28).lowpass(1200),
  // bold lead motif (inspired, not identical)
  note("a5 c6 b5 a5 g5 a5 e5 ~ a5 c6 b5 a5 g5 e5 ~", "0.5")
    .gain(0.22)
    .reverb(0.45)
    .delay(0.25, 0.2),
  // supportive low strings
  note("a2 ~ e2 ~ a2 ~ e2 ~", "1").gain(0.22).lowpass(500)
)
`.trim()
};

// ===== FUNGSI HELPER =====
export function createRandomMelody(length = 8) {
    const notes = ['c', 'd', 'e', 'f', 'g', 'a', 'b'];
    const durations = ['0.25', '0.5', '1', '2'];
    
    let melody = '';
    let rhythm = '';
    
    for (let i = 0; i < length; i++) {
        const randomNote = notes[Math.floor(Math.random() * notes.length)];
        const randomDuration = durations[Math.floor(Math.random() * durations.length)];
        
        melody += randomNote + ' ';
        rhythm += randomDuration + ' ';
    }
    
    return `note("${melody.trim()}", "${rhythm.trim()}")`;
}

export function createRandomDrumPattern(length = 8) {
    const drums = ['bd', 'sn', 'hh', 'cp'];
    const pattern = [];
    
    for (let i = 0; i < length; i++) {
        if (Math.random() > 0.3) { // 70% chance of drum hit
            const randomDrum = drums[Math.floor(Math.random() * drums.length)];
            pattern.push(randomDrum);
        } else {
            pattern.push('~'); // Rest
        }
    }
    
    return `s("${pattern.join(' ')}")`;
}

export function createRandomChordProgression(length = 4) {
    const chords = ['c', 'f', 'g', 'am', 'dm', 'em'];
    const progression = [];
    
    for (let i = 0; i < length; i++) {
        const randomChord = chords[Math.floor(Math.random() * chords.length)];
        progression.push(randomChord);
    }
    
    return `chord("${progression.join(' ')}", "2")`;
}

// ===== EXPORT SEMUA PATTERN =====
export const allPatterns = {
    ...basicMelodies,
    ...drumPatterns,
    ...chordProgressions,
    ...bassLines,
    ...effects,
    ...complexPatterns
};

// ===== FUNGSI UNTUK HTML =====
if (typeof window !== 'undefined') {
    window.basicMelodies = basicMelodies;
    window.drumPatterns = drumPatterns;
    window.chordProgressions = chordProgressions;
    window.bassLines = bassLines;
    window.effects = effects;
    window.complexPatterns = complexPatterns;
    window.djLoops = djLoops;
    window.chillLoops = chillLoops;
    window.guitarThemes = guitarThemes;
    window.createRandomMelody = createRandomMelody;
    window.createRandomDrumPattern = createRandomDrumPattern;
    window.createRandomChordProgression = createRandomChordProgression;
    window.allPatterns = allPatterns;
}
