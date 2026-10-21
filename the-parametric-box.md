# The Parametric Box

**Scope:** the guide's main build taken
whole — `examples/project-box.scad`, a
project box with a snap-on look but
honest clearances — and the three ways to
change its mind: editing variables, the
Customizer, and the command line.

## The design, in one read

```openscad
width = 80;   depth = 55;   height = 30;
wall = 2.4;   lid_height = 6;

module shell(w, d, h, t) {
    difference() {
        cube([w, d, h]);
        translate([t, t, t])
            cube([w - 2 * t, d - 2 * t, h]);
    }
}

shell(width, depth, height, wall);
```

The shell is a block minus its own
interior. The cavity starts one `wall`
above the floor and is inset one `wall`
from each side, and — chapter 4's rule —
it pokes out of the top, so the mouth is
fully open and the floor is exactly
`wall` thick. Nothing in the design is a
measurement typed twice; the lid below
derives everything from the same six
variables.

The lid is a slab the size of the box
plus a rim that drops into the mouth. The
rim is sized from the *inside* opening,
minus a **clearance** of 0.4 per side:

```openscad
inside_w = width - 2 * wall;
clearance = 0.4;
// rim is inside_w - 2 * clearance wide
```

Clearance is a printing fact, not a
modelling nicety: two surfaces printed to
exactly the same dimension do not slide
together. The model says what it did via
`echo` (chapter 5):

```console
ECHO: "inside opening: 75.2 x 50.2"
ECHO: "rim size: 74.4 x 49.4"
```

75.2 × 50.2 is the opening; 74.4 × 49.4 is
the rim — the 0.8 difference across each
dimension is the clearance, twice 0.4.
Whether 0.4 is right depends on your
printer's calibration; the point is that
it is **one named number**, adjustable in
one place.

**Check:** the pair exports side by side
in one file (the lid is translated clear
of the box), so the bounding box covers
both: x 0…170 is box (80) + gap (10) +
lid (80), z reaches the box's 30:

```console
$ openscad -o project-box.stl project-box.scad
project-box.stl: triangles=56  bytes=7391
  size 170.00 x 55.00 x 30.00   signed volume 60421.1
```

Fifty-six triangles for the whole
project. Flat boxes are cheap; it was the
curves in earlier chapters that cost.

## Changing it without editing

The variables at the top of the file
carry comments of a particular shape:

```openscad
// Outside width of the box (x)
width = 80;          // [40:200]
```

The `[40:200]` is a **Customizer**
annotation: in the graphical application
it turns the variable into a slider with
those limits, and the `/* [Box dimensions] */`
headers group the sliders into panels.
This guide runs headless, so the panel
itself is documented-only (see
`criteria.md`) — but everything the panel
*does* can be done from the command line,
and was:

**`-D name=value`** overrides a variable
for one run:

```console
$ openscad -D width=120 -o wide.stl project-box.scad
ECHO: "inside opening: 115.2 x 50.2"
  size 250.00 x 55.00 x 30.00
```

80 became 120 in the variable, and
everything downstream — cavity, lid, rim,
echoes — followed. x now spans 250: the
wider pair, side by side. Note what `-D`
cannot do: it sets variables that exist,
at the top level. It is a steering wheel,
not an editor.

**Parameter sets** (`-p file -P name`)
apply a named bundle of values saved in
JSON — the same sets the Customizer saves
from the GUI. Verified with a hand-written
set (`width 120, height 20`): the export
measured 250 × 55 × 20, the shallower
box, with the same echoes as the `-D`
run for width. Sets are how a design
keeps its standard sizes: one file of
named variants, applied by name from a
build script.

## The habit this chapter is really about

Parameters on top, derivation in the
middle, geometry at the bottom — and the
model reporting its own derived numbers
by `echo`. Follow that shape and a model
stays understandable at fifty lines and
at five hundred.
