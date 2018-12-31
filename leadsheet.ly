\version "2.18.2"
\language "english"

\header {
  title = "Title: Leadsheet with chords"
  subtitle = "The LilyPond Band"
  composer = "Oliver Klee (2018)"
  arranger = "Arr.: Oliver Klee"
  tagline = ""
}

global = {
  \key c \major
  \time 4/4
  \tempo 4 = 120
  % 1.0 would be the default value, but bigger values tend to make the lyrics
  % a lot more readable.
  \override Lyrics.LyricSpace.minimum-distance = #2.0
}

% 20 would be the default size.
#(set-global-staff-size 19)

coda = \mark \markup \center-column { \smaller "Coda" \musicglyph #"scripts.coda" }
segno = \mark \markup { \musicglyph #"scripts.segno" }
dsac = \mark \markup { \smaller "D.S. al Coda" \musicglyph #"scripts.segno"  }
toco = \mark \markup { \smaller "To Coda" \musicglyph #"scripts.coda" }

% http://lsr.di.unimi.it/LSR/Item?id=265
leftbraceForUnevenLyricLines = \set stanza = \markup {
  \hspace #1
  \translate #'(0 . 0.8) \left-brace #45
}
rightbraceForUnevenLyricLines = \set stanza = \markup {
  \hspace #1
  \translate #'(0 . 0.8) \right-brace #45
}

dropLyrics = {
  \override LyricText.extra-offset = #'(0 . -1)
  \override LyricHyphen.extra-offset = #'(0 . -1)
  \override LyricExtender.extra-offset = #'(0 . -1)
  \override StanzaNumber.extra-offset = #'(0 . -1)
}

leftbraceForEvenLyricLines = \set stanza = \markup {
  \hspace #1
  \translate #'(0 . -0.6) \left-brace #25
}

rightbraceForEvenLyricLines = \set stanza = \markup {
  \hspace #1
  \translate #'(0 . 0.4) \right-brace #25
}

showChordOnce = {
  \once \set chordChanges = ##f
}


% Intro

introHarmonies = \chordmode {
  \powerChords
  c1:1.5 | a:1.5 | f:1.5 | g:1.5 | \break
}

introRests = {
  r1 | r | r | r | \break
}


% Verse

verseHarmonies = \chordmode {
  c1 | a:m | f | e | \bar "||" \break
}

verseMelody = \relative c' {
  e2~( e4. d8 | e1) |  f2~( f8 g4 e8~ | e2 d2) |
}

verseWordsI = \lyricmode {
  \set stanza = #"1."
  Hey, __ hey. __
}

verseWordsII = \lyricmode {
  \set stanza = #"2."
  Oo, __ oo. __
}

verseWordsIII = \lyricmode {
  \set stanza = #"3."
  Hey, __ hey. __
}


% Chorus

chorusHarmonies = \chordmode {
  a1:m | f | d:7 | e | \break
}

chorusMelody = \relative c'' {
  c8 a a a~ a4 g8 a | c a a a~ a4 g8 a | c a a a~ a4 g8 a | gs gs gs gs b b\toco b4 |
}

chorusWords = \lyricmode {
  All you lyr -- ics are there,
  all you lyr -- ics are there,
  all you lyr -- ics are there,
  when you sing what you can bear.
}


% Guitar solo

soloHarmonies = \chordmode {
  c1 | a:m | f | e | \break
}

soloRests = \relative c'' {
  r1 | r | r | r2 \dsac r |
}


% Outro

outroHarmonies = \chordmode {
  c1 | a:m | f | g | \break
}

outroRests = {
  r1^\markup { \italic "Repeat and fade" } | r | r | r | \break
}


harmonies = {
  \new ChordNames {
    \set chordChanges = ##t
    \segno
    \introHarmonies

    \mark \markup{ \box "Verse" }
    \showChordOnce
    \repeat volta 2 {
      \verseHarmonies

      \mark \markup{ \box "Chorus" }
      \showChordOnce
      \chorusHarmonies
    }
    \mark \markup{ \box "Guitar solo" }
    \showChordOnce
    \soloHarmonies
    \showChordOnce
    \coda
    \repeat volta 2 {
      \outroHarmonies
    }
  }
}

music = {
  \new Staff = "voice" \with {midiInstrument = #"voice oohs"} <<
    \clef "treble_8"
    \new Voice = "melody" {
      \global
      \introRests

      \repeat volta 2 {
        \verseMelody
        \chorusMelody
      }
      \soloRests
      \repeat volta 2 {
        \outroRests
      }
    }
    \new Lyrics \lyricsto "melody" \verseWordsI
    \new Lyrics \lyricsto "melody" { \verseWordsII \chorusWords }
    \new Lyrics \lyricsto "melody" \verseWordsIII
  >>
}

\score {
  <<
    \harmonies
    \music
  >>

  \layout {}
  % The MIDI output is for "proofhearing" only. Hence, the repeats are not unfolded.
  \midi {}
}
