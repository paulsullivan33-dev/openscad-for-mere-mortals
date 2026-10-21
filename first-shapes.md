# First Shapes

**Scope:** the three solid primitives —
`cube`, `sphere`, `cylinder` — where each
one sits when you create it, and the
`$fn` dial that trades smoothness for
speed.

## Three primitives

Everything in OpenSCAD is built from a
small set of starting solids. The three
that matter first are in
`examples/primitives.scad`:

```openscad
cube([30, 20, 10]);

translate([45, 0, 8])
    sphere(r = 8);

translate([70, 0, 0])
    cylinder(h = 16, r1 = 9, r2 = 6, $fn = 48);
```

- **`cube([x, y, z])`** makes a box. Its
  corner sits at the origin and it grows
  in the positive directions: this one
  occupies x 0–30, y 0–20, z 0–10.
  (`cube(10)` makes a cube of side 10, and
  `center = true` centres it on the origin
  instead.)
- **`sphere(r = …)`** makes a ball of the
  given radius, **centred on the origin** —
  so an untranslated sphere sinks halfway
  below z = 0. The specimen lifts it by
  its radius so it rests on the ground.
- **`cylinder(h = …, r1 = …, r2 = …)`**
  makes a can standing on z = 0. `r1` is
  the bottom radius, `r2` the top; make
  them different and you get a taper or a
  cone, as here (9 at the base, 6 at the
  top). `r` sets both at once, and `d`
  spellings take diameters instead.

**Check:** render the specimen and measure
what came out. This guide measures STL
files with a small Python reader (kept
with the build; any mesh tool that reports
a bounding box does the same job):

```console
$ openscad -o primitives.stl primitives.scad
$ stl_info primitives.stl
primitives.stl: format=ascii bytes=158648 triangles=872
  bbox x 0.00..79.00  y -9.00..20.00  z 0.00..16.00
  size 79.00 x 29.00 x 16.00   signed volume 10950.0
```

Read the bounding box against the code:
the box runs x 0–30, the sphere reaches
x 53, the tapered cylinder stands at
x 70 with a base radius of 9 — so the
whole scene spans x 0–79, exactly as
measured. Its widest y, −9 to 20, is the
cylinder's base on one side and the box's
depth on the other. When the numbers you
measure match the numbers you wrote, the
model is the one you meant. (The render
also prints a **signed volume** in this
guide's measurements: for a closed,
well-formed solid it comes out positive
and close to the true volume — a cheap
health check chapter 10 leans on.)

## Nothing is round: `$fn`

A sphere in OpenSCAD is not a sphere. It
is a polyhedron — a jewel of flat faces
that approximates one. The special
variable **`$fn`** sets how many fragments
approximate a full circle, and it applies
to spheres, cylinders, and circles alike.

The cylinder above asked for `$fn = 48`.
Leave `$fn` alone and the defaults are
modest — fine for preview, visibly faceted
in a print. Raise it and two things grow
together: the smoothness, and the work.
Chapter 10 measures one sphere at
`$fn` 8, 32, and 128: the triangle count
goes 60 → 1,020 → 16,380, and the
measured volume goes from 77% of a true
sphere's to 99.9% of it. The shape you
export is the shape you approximated —
there is no rounder sphere hiding behind
the file.

Two habits follow:

- Set `$fn` **per model**, at the top
  (`$fn = 48;`), not per shape, unless a
  shape needs special treatment.
- Draft low, export high. A coarse `$fn`
  while you work keeps renders quick; the
  final export is where smoothness is
  worth paying for.

`$fa` and `$fs` exist as finer controls
(angle and size per fragment); the guide
stays with `$fn`, which is the dial
beginners actually turn, and names the
others here so their appearance in other
people's files is not a mystery.
