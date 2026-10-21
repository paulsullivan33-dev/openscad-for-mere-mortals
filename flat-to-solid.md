# Flat to Solid

**Scope:** the 2D half of the language —
`circle`, `square`, `polygon`, `offset` —
and the two extrusions that give flat
shapes height: `linear_extrude` and
`rotate_extrude`.

## Why work flat

A large family of real parts is a flat
outline with a thickness: gaskets, plates,
stencils, brackets, tags. Another family
is a profile spun around an axis: pots,
knobs, bottles, pulleys. OpenSCAD models
both by drawing **flat** and extruding,
and flat is easier: outlines are
arithmetic in two variables, and mistakes
are cheap to see.

The 2D primitives mirror the 3D ones:
`circle(r)` (with the same `$fn` control),
`square([x, y])`, `text()` (chapter 9),
and `polygon(points = [...])` for an
outline of your own points, closed
automatically. The 2D transformations
are the flat shadows of chapter 3's:
`translate`, `rotate`, `scale`, `mirror`
— plus one the 3D world lacks:

**`offset(r)`** grows a 2D outline
outward by `r` (or shrinks it, for
negative `r`), rounding outside corners
as it goes. Offsetting a square is the
one-line way to a rounded rectangle, and
offsetting an outline inward is a common
way to draw a wall's inner edge from its
outer one.

## `linear_extrude`: pull it up

```openscad
translate([34, 2, 0])
    linear_extrude(height = 4)
        offset(r = 3)
            square([30, 20]);
```

From `examples/flat.scad`: a 30 × 20
square, grown by 3 on every side, pulled
up 4 thick. Measured in the export, the
plate is 36 × 26 — offset added its 3 to
*both* sides of each dimension, the same
growth rule as minkowski's, in flat form.

`linear_extrude` also takes `twist`
(degrees of rotation from bottom to top)
and `scale` (growth of the profile as it
rises — a way to make pyramids and cones
from arbitrary outlines). The specimen's
other half is a pentagon prism twisted a
quarter-turn over its height of 30:

```openscad
translate([14, 14, 0])
    linear_extrude(height = 30, twist = 90)
        circle(r = 12, $fn = 5);
```

The placement of `translate` in that
listing is a lesson the lab learned the
hard way. **Twist pivots on the 2D
origin**, not on the profile's centre.
Draw the profile off-centre and twist,
and it swings around the axis like a
bucket on a rope — the first draft of
this specimen did exactly that, and its
bounding box (y from −26 for a 24-wide
shape) is how we knew. The rule: draw
centred on the origin, extrude, then move
the finished solid. The final specimen
measures x 2.01…67 across both objects,
with the prism standing in its intended
footprint.

## `rotate_extrude`: spin the profile

`rotate_extrude()` takes a 2D shape drawn
to the **right of the axis** (x ≥ 0) and
sweeps it a full turn around the vertical
axis. `examples/plant-pot.scad` — the pot
is the guide's whole demonstration:

```openscad
rotate_extrude()
    polygon(points = [
        [8,            0],
        [bottom_r,     0],
        [top_r,        pot_height],
        [top_r - wall, pot_height],
        [bottom_r - wall, wall],
        [8,            wall]
    ]);
```

Read the points as a walk: along the
floor's underside, up the outside of the
tapered wall, over the rim, down the
inside, and back across the floor's top
face. One closed polygon with real
thickness, so the pot is **one watertight
solid**, not an outer shell pretending.
The profile starts at radius 8 instead of
0 — the gap left in the middle of the
floor is the drainage hole, made not by
cutting but by never drawing there.

**Check:**

```console
$ openscad -o plant-pot.stl plant-pot.scad
plant-pot.stl: triangles=768
  bbox x -40.00..40.00  y -40.00..40.00  z 0.00..70.00
  signed volume 43202.4
```

Diameter 80 (twice the top radius),
height 70, positive volume — and 768
triangles, which factors as the profile's
segments times the 64 facets `$fn`
requested: the export is the surface you
specified, nothing hidden.

Two `rotate_extrude` rules worth the
space: the profile must not cross the
axis (x < 0 produces an error, not a
shape), and the resolution dial is `$fn`
on the *extrusion*, so a smooth pot wants
its `$fn` set before the call — the
specimen sets 64 at the top of the file.
