\version "2.18.2"
\language "english"

\header {
  title = "Title: SATB with individual lyrics"
  subtitle = "The LilyPond Band"
  composer = "Lily Pond (2018)"
  arranger = "Arranged by Oliver Klee"
  tagline = ""
}

% 20 would be the default size.
#(set-global-staff-size 19)

global = {
  \key a \minor
  \time 4/4
  \tempo 4 = 112
  % 1.0 would be the default value, but bigger values tend to make the lyrics
  % a lot more readable.
  \override Lyrics.LyricSpace.minimum-distance = #2.0
}


sopranoMusic = \relative c'' {
  \repeat volta 2 {
    c2 d4 e | e4. f8 e4 d | c2. b4 | c1 |
  }
}

sopranoWordsOne = \lyricmode {
  \set stanza = #"1. "
  I am the so -- pra -- no, oh yeah, oh yeah.
}

sopranoWordsTwo = \lyricmode {
  \set stanza = #"2. "
  I sing the so -- pra -- no, oh yeah, oh yeah.
}


altoMusic = \relative c'' {
  \repeat volta 2 {
    g2 b4 b | c4. c8 c4 b | a2. f4 | g1 |
  }
}

altoWordsOne = \lyricmode {
  \set stanza = #"1. "
  I am an al -- to voice, oh yeah, oh yeah.
}

altoWordsTwo = \lyricmode {
  \set stanza = #"2. "
  I sing the al -- to voice, oh yeah, oh yeah.
}


tenorMusic = \relative c {
  \repeat volta 2 {
    e2 g4 gs | a4. a8 a4 gs | e2. d4 | e1 |
  }
}

tenorWordsOne = \lyricmode {
  \set stanza = #"1. "
  I am the ten -- or voice, oh yeah, oh yeah.
}

tenorWordsTwo = \lyricmode {
  \set stanza = #"2. "
  I sing the ten -- or voice, oh yeah, oh yeah.
}


bassMusic = \relative c {
  \repeat volta 2 {
    c2 b4 b | a4. a8 a4 b | a2. g8( b) | c1 |
  }
}

bassWordsOne = \lyricmode {
  \set stanza = #"1. "
  Deep I sing, as I am the bass, oh yeah.
}

bassWordsTwo = \lyricmode {
  \set stanza = #"2. "
  Deep I sing, as I am the bass, oh yeah.
}


sopranosStaff = {
  \new Staff = "sopranos" \with {instrumentName = #"S" midiInstrument = #"voice oohs"} <<
    \clef "treble"
    \new Voice = "sopranos" {
      << \global \sopranoMusic >>
    }
  >>
}
sopranosLyrics = {
  \context Lyrics = "sopranos" \lyricsto "sopranos" <<
    { \sopranoWordsOne }
    \new Lyrics
    \with { alignBelowContext = #"sopranos" } {
      \set associatedVoice = "sopranos"
      \sopranoWordsTwo
    }
  >>
}

altosStaff = {
  \new Staff = "altos" \with {instrumentName = #"A" midiInstrument = #"voice oohs"} <<
    \clef "treble"
    \new Voice = "altos" {
      << \global \altoMusic >>
    }
  >>
}
altosLyrics = {
  \context Lyrics = "altos" \lyricsto "altos" <<
    { \altoWordsOne }
    \new Lyrics
    \with { alignBelowContext = #"altos" } {
      \set associatedVoice = "altos"
      \altoWordsTwo
    }
  >>
}

tenorsStaff = {
  \new Staff = "tenors" \with{instrumentName = #"T" midiInstrument = #"voice oohs"} <<
    \clef "treble_8"
    \new Voice = "tenors" {
      << \global \tenorMusic >>
    }
  >>
}
tenorsLyrics = {
  \context Lyrics = "tenors" \lyricsto "tenors" <<
    { \tenorWordsOne }
    \new Lyrics
    \with { alignBelowContext = #"tenors" } {
      \set associatedVoice = "tenors"
      \tenorWordsTwo
    }
  >>
}

bassesStaff = {
  \new Staff = "basses" \with{instrumentName = #"B" midiInstrument = #"voice oohs"} <<
    \clef "bass"
    \new Voice = "basses" {
      << \global \bassMusic >>
    }
  >>
}
bassesLyrics = {
  \context Lyrics = "basses" \lyricsto "basses" <<
    { \bassWordsOne }
    \new Lyrics
    \with { alignBelowContext = #"basses" } {
      \set associatedVoice = "basses"
      \bassWordsTwo
    }
  >>
}

lyricsAboveStaff = {
  % this is needed for lyrics above a staff
  \override VerticalAxisGroup.staff-affinity = #DOWN
}

% All voices in 2 systems
\book {
  \bookOutputSuffix "all-in-2-systems"
  \score {
    \new ChoirStaff <<
      \new Lyrics = "sopranos" \with \lyricsAboveStaff
      \new Staff = "women" \with {instrumentName = #"S + A" midiInstrument = #"voice oohs"} <<
        \clef "treble"
        \new Voice = "sopranos" <<
          \voiceOne
          << \global \sopranoMusic >>
        >>

        \new Voice = "altos" <<
          \voiceTwo
          << \global \altoMusic >>
        >>
      >>
      \new Lyrics = "altos" \altosLyrics

      \new Lyrics = "tenors" \with \lyricsAboveStaff
      \new Staff = "men" \with{instrumentName = #"T + B" midiInstrument = #"voice oohs"} <<
        \clef "bass"
        \new Voice = "tenors" <<
          \voiceOne
          << \global \tenorMusic >>
        >>
        \new Voice = "basses" <<
          \voiceTwo
          << \global \bassMusic >>
        >>
      >>
      \new Lyrics = "basses" \bassesLyrics

      \sopranosLyrics
      \tenorsLyrics
    >>

    \layout {}
  }
}

% All voices in 4 systems
\book {
  \bookOutputSuffix "all-in-4-systems"
  \score {
    \new ChoirStaff <<
      \sopranosStaff
      \new Lyrics = "sopranos" \sopranosLyrics

      \altosStaff
      \new Lyrics = "altos" \altosLyrics

      \tenorsStaff
      \new Lyrics = "tenors" \tenorsLyrics

      \bassesStaff
      \new Lyrics = "basses" \bassesLyrics
    >>

    \layout {}
  }
}

\book {
  \bookOutputSuffix "all"
  \score {
    \unfoldRepeats {
      \new ChoirStaff <<
        \sopranosStaff
        \altosStaff
        \tenorsStaff
        \bassesStaff
      >>
    }
    \midi {}
  }
}

% Sopranos
\book {
  \bookOutputSuffix "only-sopranos"
  \score {
    \new ChoirStaff <<
      \sopranosStaff
      \new Lyrics = "sopranos" \sopranosLyrics
    >>

    \layout {}
  }

  \score {
    \unfoldRepeats {
      \sopranosStaff
    }
    \midi {}
  }
}

% Altos
\book {
  \bookOutputSuffix "only-altos"
  \score {
    \new ChoirStaff <<
      \altosStaff
      \new Lyrics = "altos" \altosLyrics
    >>

    \layout {}
  }

  \score {
    \unfoldRepeats {
      \altosStaff
    }
    \midi {}
  }
}

% Tenors
\book {
  \bookOutputSuffix "only-tenors"
  \score {
    \new ChoirStaff <<
      \tenorsStaff
      \new Lyrics = "tenors" \tenorsLyrics
    >>

    \layout {}
  }

  \score {
    \unfoldRepeats {
      \tenorsStaff
    }
    \midi {}
  }
}

% Basses
\book {
  \bookOutputSuffix "only-basses"
  \score {
    \new ChoirStaff <<
      \bassesStaff
      \new Lyrics = "basses" \bassesLyrics
    >>

    \layout {}
  }

  \score {
    \unfoldRepeats {
      \bassesStaff
    }
    \midi {}
  }
}

\book {
  \bookOutputSuffix "minus-sopranos"
  \score {
    \unfoldRepeats {
      \new ChoirStaff <<
        \altosStaff
        \tenorsStaff
        \bassesStaff
      >>
    }
    \midi {}
  }
}
\book {
  \bookOutputSuffix "minus-altos"
  \score {
    \unfoldRepeats {
      \new ChoirStaff <<
        \sopranosStaff
        \tenorsStaff
        \bassesStaff
      >>
    }
    \midi {}
  }
}
\book {
  \bookOutputSuffix "minus-tenors"
  \score {
    \unfoldRepeats {
      \new ChoirStaff <<
        \sopranosStaff
        \altosStaff
        \bassesStaff
      >>
    }
    \midi {}
  }
}
\book {
  \bookOutputSuffix "minus-basses"
  \score {
    \unfoldRepeats {
      \new ChoirStaff <<
        \sopranosStaff
        \altosStaff
        \tenorsStaff
      >>
    }
    \midi {}
  }
}
