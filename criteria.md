# Writing Criteria

Every guide in this repo is written to the same
standard. If you're adding or editing a guide —
human or AI — hold it to these.

1. **Plain words, real ideas.** Simple language,
   never dumbed-down concepts. Explain jargon on
   first use; collect terms in the glossary.
2. **No hype.** No marketing adjectives, no
   "revolutionary," no promises about what
   something will do for the reader.
3. **Honest about limits.** Say what the thing
   *can't* do. State uncertainty instead of
   smoothing it over. Validation notes include
   what remains unverified.
4. **No invented numbers.** Benchmarks, defaults,
   and specs are either measured or qualified with
   "depends on your setup." If it wasn't tested,
   say so.
5. **Checkable.** Commands are meant to be run,
   with "Check:" blocks showing what success looks
   like. Sources are linked, not asserted.
6. **Respect the reader's setup.** Call out
   Windows/Mac/Linux differences. Don't assume a
   GPU, a budget, or prior experience.
7. **Safety isn't skipped.** Real risks get
   stated plainly, not buried.
8. **Scoped.** Each guide says what it covers and
   points elsewhere for the rest. No guide
   pretends to be the whole subject.
9. **Structure over prose.** Tables, before/after
   examples, symptom → fix. Scannable beats essay.

## Verification notes for this guide

Standard 3 and 4 applied to this guide,
specifically. **OpenSCAD 2021.01** (the
distro package, `2021.01-6build4`) was on
the build machine — the current stable
release — and every command quoted in the
chapters was run with it, headless, on
the specimens in `examples/`. Exports
were measured with a small Python STL
reader kept with the build (triangle
count, bounding box, signed volume); PNG
exports were verified as image data with
PIL (dimensions, background colour,
non-background pixel fraction). Working
transcripts are kept with the build
(`openscad-lab/transcripts/`).

**Verified by running, per chapter:**

- *Ch. 1:* `--version` (2021.01); the
  export command shape used throughout.
- *Ch. 2:* the primitives scene exported:
  872 triangles, bounding box
  79 × 29 × 16, signed volume 10,950 —
  read back against the code's own
  numbers.
- *Ch. 3:* the transforms scene: bounding
  box x −11.31…99.96, y 0…33.96,
  z 0…15.96, including the mirror pair
  landing at x = 92 and x = 74 exactly
  where the flipped translate predicts.
- *Ch. 4:* the boolean scene: 1,840
  triangles, volume 30,713.5, render
  ~3.9 s against the primitives scene's
  ~0.3 s on the same machine.
- *Ch. 5:* the project box's `echo`
  output on the console and captured via
  `-o file.echo`: "inside opening:
  75.2 x 50.2", "rim size: 74.4 x 49.4".
- *Ch. 6:* the hull plate and minkowski
  block: overall bounding box
  97 × 40 × 10 (the minkowski part grown
  by the sphere's diameter, as the
  chapter states); the rounded file's
  ~1.0 s against primitives' ~0.33 s.
- *Ch. 7:* the pot: 768 triangles,
  80 × 80 × 70, volume 43,202.4, positive
  from a single rotate_extrude polygon.
  The offset plate measured 36 × 26 from
  a 30 × 20 square at offset 3. The
  twisted prism — see the specimen
  correction below.
- *Ch. 8:* the box default (56 triangles,
  170 × 55 × 30 across both parts),
  `-D width=120` (echo 115.2, span 250),
  and a hand-written parameter set via
  `-p`/`-P` (250 × 55 × 20 for width 120,
  height 20).
- *Ch. 9:* the name tag in two names:
  "Ada" 1,236 triangles / ~1.8 s render,
  `"Grace"` via `-D name=` 1,948
  triangles / ~4.8 s; both 76 × 28 × 4.2.
  Liberation Sans present in the build
  machine's font list (fc-list).
- *Ch. 10:* STL vs 3MF sizes for the same
  geometry (7,391 vs 2,020 bytes); the
  `$fn` series on an r=20 sphere —
  60 / 1,020 / 16,380 triangles,
  volumes 25,832 / 32,976 / 33,477
  against the true 33,510, diameters
  36.96 / 39.81 / 39.99; PNG exports
  under `xvfb-run` at exactly 800 × 600,
  15.7% and 17.1% non-background pixels;
  the same PNG export with no display:
  "Unable to open a connection to the X
  server" / "Can't create OpenGL
  OffscreenView", and a segfault (exit
  139) after the messages on this build.
- *Ch. 11:* the bracket (548 triangles,
  50 × 30 × 50, volume 11,182.4). The
  batch-rename `-D` quoting and the
  two-variable box run are presented as
  recipes built from captures in
  chapters 8–9, not as separate captures.
- *Ch. 13:* both failure fixtures run:
  the typo'd variable producing two
  WARNINGs, a fallback 1 × 1 × 1 cube in
  the export, and exit 0; `--hardwarnings`
  stopping the same file with exit 1 and
  no geometry; the parse error producing
  "ERROR: Parser error…", exit 1, and no
  output file.

**Specimen corrections made during the
build (declared):** two specimens were
rewritten after their first captures
contradicted their intended lesson, and
both were recaptured. (1) `flat.scad`'s
twisted prism originally drew its
profile off-centre; the measured
bounding box (y to −26) showed the twist
sweeping the profile around the 2D
origin. The specimen now centres the
profile first — and chapter 7 teaches
the rule on that evidence. (2)
`transforms.scad`'s mirror pair
originally landed on top of another
specimen (mirror flips the inner
translate, as chapter 3 explains); it
was moved to its own lane and now
measures as the chapter describes.
`broken.scad`'s header comment was
corrected after capture: the export is
not empty but a fallback 1 × 1 × 1 cube —
the transcripts show this, and chapter
13 says it.

**Documented-only (not run), and why:**

- *The graphical application as a whole*
  — editor, F5 preview, F6 render, the
  Customizer panel, the font dialog: the
  build machine has no display. The CLI
  equivalents the chapters depend on
  (`-D`, `-p`/`-P`, `--render`) were run
  for real; GUI interactions are
  described, never quoted as output.
- *Printing itself.* No printer was
  attached to the build. Wall-thickness
  and orientation guidance in chapter 10
  is stated as design reasoning with its
  numbers named as such, not as print
  results.
- *Windows and Mac behaviour* — install
  routes, font rosters, GUI details — is
  described from the tools' documentation
  and the chapters say so in place. The
  font warning in chapter 9 (a model
  silently re-renders in a fallback font)
  is documented behaviour; the build
  verified Liberation Sans rendering on
  Linux only.
- *The neighbours* (chapter 12) are
  placed from their documentation; none
  was installed or run for this guide.
- *Slicers* are named and scoped, not
  operated.

Specimen discipline, for the record:
every model is an invented, generic
household object (project box, plant
pot, name tag, bracket, spacer); every
name in the text is invented ("Ada",
"Grace", "Lin"); nothing is modelled on
any real organisation, event, or
person's belongings.
