# 🎵 Strudel Music Project - Membuat Beat Melalui Coding

Project ini adalah implementasi lengkap untuk membuat musik dan beat melalui coding menggunakan **Strudel** (JavaScript) dan **SuperCollider**. Cocok untuk pemula yang ingin belajar live coding musik!

## 🚀 Fitur

### 🌐 Web Interface (Strudel)
- **9+ Contoh Musik Siap Pakai**: Dari melodi sederhana hingga DJ loops kompleks
- **Live Coding Area**: Ketik kode Strudel Anda sendiri dan dengarkan hasilnya secara real-time
- **Drum Patterns**: Berbagai pattern drum (basic, funk, hip-hop, breakbeat)
- **Chord Progressions**: Pop, jazz, blues, dan minor progressions
- **DJ Loops**: House (124 BPM), Techno (128 BPM), Chill (90 BPM)
- **Guitar Themes**: Pirates-style theme dengan arpeggio
- **Efek Audio**: Reverb, delay, gain, pan, dan speed control
- **UI Modern**: Interface yang user-friendly dengan gradient design

### 🎛️ SuperCollider Files (.scd)
- **cinematic.scd**: Komposisi cinematic dengan pad, choir, bass, arpeggio, dan atmosfer
- **dj_loop.scd**: DJ club remix dengan struktur arrangement lengkap (intro, build-up, drop, breakdown)
- **saas.scd**: Musik dreamy/ambient dengan bass dan gitar pad yang lembut

## 📦 Instalasi

### Untuk Web Interface (Strudel)

#### 1. Install Dependencies
```bash
npm install
```

#### 2. Jalankan Development Server
```bash
npm run dev
```

#### 3. Buka Browser
Buka `http://localhost:5173` di browser Anda

### Untuk SuperCollider Files

#### 1. Install SuperCollider
- Download dari [supercollider.github.io](https://supercollider.github.io/)
- Install sesuai sistem operasi Anda

#### 2. Buka File .scd
- Buka SuperCollider IDE
- Buka file `.scd` yang ingin Anda jalankan:
  - `cinematic.scd` - untuk musik cinematic
  - `dj_loop.scd` - untuk DJ loop dengan arrangement
  - `saas.scd` - untuk musik dreamy/ambient

#### 3. Jalankan Kode
- Pilih seluruh isi file (Ctrl+A / Cmd+A)
- Tekan Ctrl+Enter (Windows/Linux) atau Cmd+Enter (Mac)
- Musik akan mulai bermain otomatis

## 🎼 Contoh Penggunaan

### 🌐 Strudel (Web Browser)

#### Melodi Sederhana
```javascript
note("c d e f g", "1 0.5 0.5 1 2")
```

#### Drum Pattern
```javascript
stack(
  s("bd*4"),        // Bass drum 4x
  s("~ sn ~ sn"),   // Snare pada beat 2 dan 4
  s("hh*8")         // Hi-hat 8x
)
```

#### Chord Progression
```javascript
chord("c f g c", "2")
```

#### Melodi dengan Efek
```javascript
note("c4 d4 e4 f4 g4 a4 b4 c5", "0.5")
  .gain(0.3)        // Volume 30%
  .reverb(0.8)      // Reverb 80%
  .delay(0.5, 0.3)  // Delay 0.5s, feedback 30%
```

#### Pattern Kompleks
```javascript
stack(
  note("c4 e4 g4", "2").gain(0.4),  // Melodi
  note("c2", "1").gain(0.6),        // Bass
  s("bd*2 ~ sn ~ bd*2")             // Drum
)
```

#### DJ Loop (House 124 BPM)
```javascript
setBPM(124);
stack(
  s("bd*4").gain(0.9),
  s("~ cp ~ cp").gain(0.55),
  s("hh*12").gain(0.16),
  note("c2 ~ c2 ~", "0.5").gain(0.38),
  note("~ e4g4b4 ~ e4g4b4", "0.5").gain(0.22).reverb(0.35)
)
```

### 🎛️ SuperCollider

#### Menggunakan cinematic.scd
1. Buka file `cinematic.scd` di SuperCollider IDE
2. Pilih semua (Ctrl+A) dan jalankan (Ctrl+Enter)
3. Musik akan mulai otomatis dan berhenti setelah 90 detik
4. File akan direkam ke `D:/soundtrack/cinematic2.wav`

#### Menggunakan dj_loop.scd
1. Buka file `dj_loop.scd` di SuperCollider IDE
2. Pilih semua dan jalankan
3. Pattern akan mulai otomatis dengan struktur:
   - **Intro** (0-8 bar): Kick saja
   - **Build-up** (8-32 bar): Tambah hi-hat, snare, pad, riser
   - **Drop** (32 bar): Full arrangement dengan bassline
   - **Breakdown** (64 bar): Hanya pad dan atmosfer
   - **Drop kembali** (80 bar): Full arrangement lagi
   - **Outro** (112 bar): Fade out

**Kontrol Manual:**
```supercollider
~start.();  // Mulai semua pattern
~stop.();   // Hentikan semua pattern
~bpm = 126; // Ubah tempo (lalu restart clock)
```

#### Menggunakan saas.scd
1. Buka file `saas.scd` di SuperCollider IDE
2. Pilih semua dan jalankan
3. Musik dreamy/ambient akan mulai dengan bass dan gitar pad

## 📁 Struktur Project

```
strudel/
├── index.html          # Web interface utama
├── examples.js         # Kumpulan pattern Strudel (melodi, drum, chord, DJ loops)
├── package.json        # Dependencies dan scripts
├── vite.config.js      # Konfigurasi Vite
│
├── cinematic.scd       # SuperCollider: Komposisi cinematic (90 detik, auto-record)
├── dj_loop.scd         # SuperCollider: DJ club remix dengan arrangement lengkap
└── saas.scd            # SuperCollider: Musik dreamy/ambient
```

## 🎯 Perbedaan Strudel vs SuperCollider

### Strudel (Web)
- ✅ **Mudah digunakan**: Tidak perlu install, langsung di browser
- ✅ **Live coding**: Edit kode dan langsung dengar hasilnya
- ✅ **Portable**: Bisa dijalankan di mana saja
- ⚠️ **Terbatas**: Menggunakan Web Audio API (latensi lebih tinggi)

### SuperCollider
- ✅ **Profesional**: Audio engine native, latensi sangat rendah
- ✅ **Powerful**: Lebih banyak kontrol dan efek
- ✅ **Recording**: Bisa langsung record ke file audio
- ⚠️ **Perlu install**: Harus install SuperCollider terlebih dahulu

## 🎹 Notasi Musik

### Not Dasar
- `c`, `d`, `e`, `f`, `g`, `a`, `b` = Not natural
- `c#`, `d#`, `f#`, `g#`, `a#` = Not sharp
- `cb`, `db`, `eb`, `gb`, `ab`, `bb` = Not flat

### Oktav
- `c4` = Middle C (oktav 4)
- `c5` = C satu oktaf di atas middle C
- `c3` = C satu oktav di bawah middle C

### Durasi
- `1` = Whole note (4 beats)
- `2` = Half note (2 beats)
- `0.5` = Quarter note (1 beat)
- `0.25` = Eighth note (0.5 beat)

## 🥁 Drum Samples

### Basic Drums
- `bd` = Bass drum
- `sn` = Snare drum
- `hh` = Hi-hat
- `cp` = Clap
- `cy` = Cymbal

### Pattern Examples
- `bd*4` = Bass drum 4 kali berturut-turut
- `~ sn ~ sn` = Snare pada beat 2 dan 4 (rest pada 1 dan 3)
- `hh*8` = Hi-hat 8 kali

## 🔧 Fungsi Helper (Strudel)

File `examples.js` menyediakan berbagai pattern dan fungsi helper:

```javascript
// Pattern yang tersedia di window object
window.basicMelodies.cMajorScale
window.drumPatterns.basicBeat
window.chordProgressions.popProgression
window.djLoops.house124
window.chillLoops.chill90
window.guitarThemes.piratesMinor

// Fungsi random generator
createRandomMelody(8)           // Generate melodi random
createRandomDrumPattern(8)      // Generate drum pattern random
createRandomChordProgression(4) // Generate chord progression random
```

### Contoh Penggunaan di Live Coding Area

```javascript
// Copy-paste ini ke Live Coding Area di browser:

// 1. Basic melody
note("c d e f g a b c5", "0.5")

// 2. Funk beat
stack(
  s("bd ~ ~ bd ~ ~ bd ~"),
  s("~ ~ sn ~ ~ ~ sn ~"),
  s("hh*8")
)

// 3. Pop chord progression
chord("c g am f", "2")

// 4. Full arrangement
stack(
  note("c4 e4 g4", "2").gain(0.4).reverb(0.3),
  note("c2", "1").gain(0.6),
  s("bd*2 ~ sn ~ bd*2"),
  note("c4 d4 e4 f4 g4 a4 b4 c5", "0.5").gain(0.3).delay(0.3, 0.2)
)
```

## 🎵 Live Coding Tips

### Di Browser (Strudel)
1. **Eksperimen**: Coba berbagai kombinasi not dan rhythm di Live Coding Area
2. **Belajar**: Pahami bagaimana setiap fungsi bekerja dengan mencoba contoh-contoh
3. **Buat Musik**: Buat komposisi musik Anda sendiri dengan menggabungkan pattern
4. **Iterasi**: Modifikasi pattern secara real-time dan dengar hasilnya langsung
5. **Stop**: Gunakan `hush()` untuk menghentikan semua suara

### Di SuperCollider
1. **Edit Pattern**: Ubah nilai di file `.scd` dan jalankan ulang
2. **Kontrol Real-time**: Gunakan `~start.()` dan `~stop.()` untuk kontrol
3. **Ubah Tempo**: Edit `~bpm` dan restart clock
4. **Monitor**: Gunakan `s.freqscope` dan `s.scope` untuk melihat spektrum audio

## 🚨 Troubleshooting

### Tidak Ada Suara?
1. **Refresh halaman** dan klik di area halaman
2. **Pastikan browser** mendukung Web Audio API
3. **Check console** untuk error messages
4. **Allow audio** permission jika diminta browser

### Error "AudioContext not supported"?
- Gunakan browser modern (Chrome, Firefox, Safari, Edge)
- Pastikan tidak ada extension yang memblokir audio

### Pattern tidak berhenti?
- Gunakan tombol "Stop" atau ketik `hush()` di live coding area

## 📚 Referensi & Learning Resources

### Strudel
- [Strudel Documentation](https://strudel.cc/learn/getting-started/)
- [Strudel Examples](https://strudel.cc/learn/examples/)
- [TidalCycles](https://tidalcycles.org/) - Inspirasi untuk Strudel

### SuperCollider
- [SuperCollider Documentation](https://doc.sccode.org/)
- [SuperCollider Tutorials](https://supercollider.github.io/tutorials/)
- [SuperCollider Examples](https://github.com/supercollider/supercollider/tree/develop/examples)

### Web Audio
- [Web Audio API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API)

## 🎯 Tips & Tricks

### Untuk Pemula
1. **Mulai Sederhana**: Mulai dengan pattern sederhana, lalu tambah kompleksitas
2. **Gunakan Stack**: Kombinasikan multiple pattern dengan `stack()`
3. **Eksperimen Durasi**: Coba berbagai durasi untuk rhythm yang menarik
4. **Efek Bertahap**: Tambah efek satu per satu untuk memahami pengaruhnya
5. **Pattern Repetitif**: Gunakan `*` untuk mengulang pattern

### Advanced Tips
1. **Layering**: Gabungkan melodi, bass, dan drum dengan `stack()` untuk full arrangement
2. **Sidechain**: Di SuperCollider, gunakan sidechain untuk efek pumping (seperti di `dj_loop.scd`)
3. **Automation**: Gunakan `Pseg` atau `LFNoise1` untuk parameter yang berubah seiring waktu
4. **Recording**: Di SuperCollider, gunakan `s.record()` untuk capture audio langsung
5. **BPM Sync**: Gunakan `setBPM()` di Strudel atau `TempoClock` di SuperCollider untuk tempo yang konsisten

## 🎓 Belajar Membuat Beat

### Langkah 1: Pahami Dasar-Dasar
1. **Not dan Durasi**: Pelajari notasi musik dasar (c, d, e, f, g, a, b) dan durasi (1, 0.5, 0.25)
2. **Drum Samples**: Kenali sample drum dasar (bd, sn, hh, cp, cy)
3. **Pattern**: Pahami cara membuat pattern dengan spasi dan `~` untuk rest

### Langkah 2: Coba Contoh
1. Mulai dengan contoh sederhana di web interface
2. Modifikasi sedikit-sedikit dan dengar perubahannya
3. Coba gabungkan beberapa pattern dengan `stack()`

### Langkah 3: Buat Beat Sendiri
1. Tentukan tempo dan genre (house, techno, hip-hop, dll)
2. Buat drum pattern dasar dulu
3. Tambah bass line
4. Tambah melodi atau chord
5. Tambah efek untuk memperkaya suara

### Langkah 4: Advanced
1. Coba file SuperCollider untuk kontrol lebih detail
2. Eksperimen dengan efek dan automation
3. Buat struktur arrangement (intro, verse, chorus, outro)

## 🤝 Kontribusi

Feel free untuk:
- Menambah contoh pattern baru
- Improve UI/UX
- Tambah fitur baru
- Report bugs
- Share beat yang Anda buat!

## 📄 License

MIT License - feel free untuk menggunakan project ini untuk apapun!

---

**Happy Coding & Happy Music Making! 🎵✨**

*Project ini dibuat untuk membantu Anda belajar membuat beat melalui coding. Mulai dari yang sederhana, eksperimen, dan nikmati prosesnya!*
