\version "2.18.2"
\language "english"

\header {
  title = "Title: Duet with individual lyrics and harmonies"
  subtitle = "The LilyPond Band"
  composer = "Lily Pond (2018)"
  arranger = "Arranged by Oliver Klee"
  tagline = ""
}

global = {
  \key c \major
  \time 4/4
  \tempo 4 = 112
  % 1.0 would be the default value, but bigger values tend to make the lyrics
  % a lot more readable.
  \override Lyrics.LyricSpace.minimum-distance = #2.0
}

% 20 would be the default size.
#(set-global-staff-size 19)


verseHarmonies = \chordmode {
  c2 g4 e:7 | a2.:m e4:7 | e2.:m g4:7 | c1 |
}

harmonies = {
  \new ChordNames {
    \set majorSevenSymbol = \markup { maj7 }
    \set additionalPitchPrefix = #"add"
    \powerChords

    \set chordChanges = ##t
    \repeat volta 2 {
      \verseHarmonies
    }
  }
}


sopranoMusic = \relative c' {
  \repeat volta 2 {
    c2 d4 e | e4. f8 e4 d | c2. b4 | c1 |
  }
}

sopranoWordsI = \lyricmode {
  \set stanza = #"1. "
  I am the so -- pra -- no, oh yeah, oh yeah.
}

sopranoWordsII = \lyricmode {
  \set stanza = #"2. "
  I sing the so -- pra -- no, oh yeah, oh yeah.
}


tenorMusic = \relative c {
  \repeat volta 2 {
    e2 g4 gs | a4. a8 a4 gs | e2. d4 | e1 |
  }
}

tenorWordsI = \lyricmode {
  \set stanza = #"1. "
  I am the ten -- or voice, oh yeah, oh yeah.
}

tenorWordsII = \lyricmode {
  \set stanza = #"2. "
  I sing the ten -- or voice, oh yeah, oh yeah.
}


sopranosStaff = {
  \new Staff = "sopranos" \with {midiInstrument = #"voice oohs"} <<
    \harmonies

    \clef "treble"
    \new Voice = "sopranos" {
      << \global \sopranoMusic >>
    }
  >>
}
sopranosLyrics = {
  <<
    \new Lyrics \lyricsto "sopranos" \sopranoWordsI
    \new Lyrics \lyricsto "sopranos" \sopranoWordsII
  >>
}

tenorsStaff = {
  \new Staff = "tenors" \with{midiInstrument = #"voice oohs"} <<
    \harmonies

    \clef "treble_8"
    \new Voice = "tenors" {
      << \global \tenorMusic >>
    }
  >>
}
tenorsLyrics = {
  <<
    \new Lyrics \lyricsto "tenors" \tenorWordsI
    \new Lyrics \lyricsto "tenors" \tenorWordsII
  >>
}



duet = {
  \new ChoirStaff <<
    \harmonies

    \new Staff = "women" \with {midiInstrument = #"voice oohs"} <<
      \clef "treble"
      \new Voice = "sopranos" {
        << \global \sopranoMusic >>
      }
    >>

    \sopranosLyrics

    \new Staff = "men" \with{midiInstrument = #"voice oohs"} <<
      \clef "treble_8"
      \new Voice = "tenors" {
        << \global \tenorMusic >>
      }
    >>

    \tenorsLyrics
  >>
}

% Layout
\book {
  \score {
    <<
      \duet
    >>

    \layout {}
  }
}

% All voices as MIDI
\book {
  \bookOutputSuffix "all"
  \score {
    <<
      \unfoldRepeats {
        \duet
      }
    >>
    \midi {}
  }
}

% Sopranos
\book {
  \bookOutputSuffix "sopranos"
  \score {
    \unfoldRepeats {
      \sopranosStaff
    }
    \midi {}
  }
}

% Tenors
\book {
  \bookOutputSuffix "tenors"
  \score {
    \unfoldRepeats {
      \tenorsStaff
    }
    \midi {}
  }
}
