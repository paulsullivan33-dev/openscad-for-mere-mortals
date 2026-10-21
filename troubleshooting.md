# Troubleshooting

**Scope:** failures in the order a
beginner meets them — the successful
export of the wrong thing, the warning
that wasn't heeded, the empty render,
the vanished hole — each with its
evidence and its fix.

## It exported fine, and it's wrong

The signature OpenSCAD failure. From
`examples/broken.scad`, whose cube names
a variable `widht` that doesn't exist:

```console
$ openscad -o broken.stl broken.scad
WARNING: Ignoring unknown variable 'widht' in file broken.scad, line 8
WARNING: Unable to convert cube(size=[undef, 20, 10], ...)
    parameter to a number or a vec3 of numbers in file broken.scad, line 8
[exit 0]
```

And the export is a **1 × 1 × 1 cube** —
the fallback when the size couldn't be
read — 12 facets of plausible, printable,
entirely wrong object. Unknown names
become `undef`; `undef` propagates into
geometry as defaults and disappearances;
the run still succeeds.

Defences, in order of strength:

1. **Read the warnings.** Every one.
   They print on the console during
   export; in a script, capture stderr
   rather than discarding it.
2. **`--hardwarnings`** promotes the
   first warning to a stop. The same
   fixture under it:

   ```console
   $ openscad --hardwarnings -o broken2.stl broken.scad
   WARNING: Ignoring unknown variable 'widht' ...
   TRACE: called by 'cube' in file broken.scad, line 8
   Current top level object is empty.
   [exit 1]
   ```

   Use it in build scripts and CI, where
   nobody is watching the console.
3. **Measure the export** (chapter 10).
   A 1 mm cube where a 30 × 20 × 10 block
   was designed fails the bounding-box
   check at a glance.

## It won't read the file at all

```console
$ openscad -o syntax-error.stl syntax-error.scad
ERROR: Parser error: syntax error in file syntax-error.scad, line 6
Can't parse file 'syntax-error.scad'!
[exit 1]
```

The honest failure: a genuine syntax
error is caught before evaluation, the
exit code is 1, and no output file is
created. Contrast with the section above
and calibrate accordingly: **ERROR means
stopped; WARNING means it kept going
with something.** The line number is
where the parser noticed, which for a
missing bracket is the end of the
statement, not the scene of the crime —
search upward for the unclosed `[`, `(`,
or `{`.

## The render is empty

"Current top level object is empty" (or
an export with no triangles) has three
usual causes:

- **A difference ate everything** — the
  cutter was bigger than the target, or
  the operands are in the wrong order
  (chapter 4: the thing being cut goes
  first).
- **Everything is `undef`** — a variable
  name typo'd upstream, geometry quietly
  never created. See warnings, above.
- **The shapes don't touch the world you
  think they do** — translated far away,
  or scaled by a fraction into microns.
  The bounding box of the export (or its
  absence) tells you.

## The hole (or the part) isn't there

A `difference` whose cutter never
overlaps its target subtracts nothing,
silently (chapter 4). Check by volume:
the export's measured volume equals the
uncut solid's. Similarly, a union of
parts that don't touch is legal and
exports as disjoint solids — the project
box and its lid do this on purpose; a
bracket whose leg misses the other leg
by a typo does it by accident. The
render report's volume count and your
own eyes on the PNG are the checks.

## The picture won't export (headless Linux)

PNG export wants a display. Without one:

```console
Unable to open a connection to the X server.
Can't create OpenGL OffscreenView.
```

Geometry exports (STL, 3MF) never wanted
one — this failure is picture-only. Run
under `xvfb-run -a`, as chapter 10 does,
or export the PNG from the GUI on a
desktop machine. On the build machine
the un-wrapped command went further and
segfaulted after printing those lines
(exit 139): a bug in that build's
error path, and one more reason to wrap
it.

## The render takes forever

In the order the guide has met the
causes:

1. **`$fn` too high for the part** —
   chapter 10's table. Draft at 32; raise
   only for the final export, and only
   where the curve is big enough for
   facets to show.
2. **`minkowski()`** — chapter 6. Coarsen
   the rounding shape, round fewer
   things, or restructure.
3. **Deep boolean chains over curved
   parts** — chapter 4 measured 3.9 s for
   a small scene. Hundreds of curved
   cuts are minutes. There is no progress
   bar in a batch run; the console's
   per-export timing lines are your
   evidence it is working, not hung.
4. **Text** — chapter 9: a five-letter
   name cost more time than the whole
   project box. Long strings at high
   detail are real work.
