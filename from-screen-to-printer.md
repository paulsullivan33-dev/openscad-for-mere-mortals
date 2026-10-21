# From Screen to Printer

**Scope:** getting geometry out — STL,
3MF, and PNG exports from the command
line — what the export does and does not
guarantee, and the `$fn` experiment that
prices smoothness.

## The export commands

```console
$ openscad -o model.stl model.scad        # the printer's staple
$ openscad --export-format 3mf -o model.3mf model.scad
$ xvfb-run -a openscad -o model.png --render \
      --imgsize=800,600 --autocenter --viewall model.scad
```

The extension of `-o` chooses the format.
STL is the universal exchange format for
printing; 3MF is its modern successor —
for the project box, the same geometry
measured **7,391 bytes as ASCII STL and
2,020 bytes as 3MF**. Slicers accept
both; 3MF also carries units and part
structure that STL cannot express.

The PNG line deserves its wrapping: on
the build machine (a headless Linux box),
a bare PNG export fails — there is no
display for OpenSCAD's OpenGL view:

```console
Unable to open a connection to the X server.
Can't create OpenGL OffscreenView.
```

`xvfb-run` supplies a virtual display and
the export then succeeds. The failure is
a PNG-export fact, **not** a geometry
fact: STL and 3MF exports render in pure
computation and never wanted a display.
(On a desktop machine with a real screen
none of this arises; on Windows and Mac
the GUI is the usual PNG source anyway.)
The pictures in this guide's build were
verified as data, not eyeballed: both
came out at exactly 800 × 600 with a pale
background and 15–17% of pixels drawn
over by model — geometry was really
rendered into them.

## What an STL is — and is not

An STL file is a **bag of triangles**: so
many flat facets with corners, and
nothing else. No units (millimetres by
convention — chapter 1), no colour, no
"this is a lid", no guarantee the
triangles even form a closed solid. The
format trusts the producer.

That is why this guide measures exports
instead of admiring them. The three
checks, all used throughout:

- **Bounding box** — the size the printer
  thinks the object is. Wrong box, wrong
  part, every time.
- **Triangle count** — near what the
  geometry implies. A holed plate with
  fewer triangles than an unholed one is
  telling you something.
- **Signed volume** — computed from the
  triangles, it comes out positive and
  plausible for a closed, outward-facing
  mesh. A negative or absurd volume means
  the mesh is inside-out or open,
  whatever the picture looked like.

OpenSCAD's own render report helps too:
every export in the transcripts ends with
a summary, and the line to look for is
`Simple: yes` — CGAL's verdict that the
rendered solid is a single well-formed
polyhedron. A model that renders `Simple:
yes` and exports a positive measured
volume has earned its trip to the slicer.

## A rendered model is not a printable model

The remaining honesty, and the chapter
this guide most wants read before a first
print:

- **Manifold is necessary, not
  sufficient.** A watertight mesh can
  still have walls too thin to print.
  The box's wall is 2.4 — several nozzle
  widths on a typical 0.4 nozzle, chosen
  for that reason. A wall of 0.5 renders
  beautifully and prints as lace, if at
  all. Wall thickness is a *design*
  number; put it in a variable and think
  about it on purpose.
- **Overhangs and supports are the
  slicer's world**, decided by orientation
  and the printer, not by OpenSCAD. The
  lid prints rim-up or rim-down; the pot
  prints base-down. Nothing in the model
  file knows.
- **The export is the approximation.**
  Which brings us to the experiment.

## The `$fn` experiment, measured

`examples/fn-demo.scad` is one sphere,
radius 20, rendered at three settings. A
true sphere of that radius has volume
33,510 and diameter 40:

| `$fn` | triangles | STL bytes | measured volume | measured diameter |
|---|---|---|---|---|
| 8 | 60 | 10,944 | 25,832 (77%) | 36.96 |
| 32 | 1,020 | 196,310 | 32,976 (98.4%) | 39.81 |
| 128 | 16,380 | 3,205,370 | 33,477 (99.9%) | 39.99 |

Read it as a price list. At `$fn = 8` the
"sphere" is a gemstone: nearly a quarter
of the volume missing and 3 mm narrower
than designed — a printed ball would
measure small, because it *is* small. At
32 the shape is honestly round for most
purposes at a twentieth of the top
setting's triangle count. At 128 the file
is 3.2 MB to buy the last 1.5% of volume.

One sphere is cheap at any setting (its
render still took milliseconds); the cost
compounds when high-`$fn` curves are cut,
hulled, and minkowski'd by the dozen.
Set `$fn` for the size of the curve and
the needs of the part — small holes print
fine at modest `$fn` because their facets
are tiny in absolute terms — and never
let a draft setting ride along into the
export by accident.
