# Adding and Cutting

**Scope:** the three boolean operations —
`union`, `difference`, `intersection` —
that combine solids, and the working
habits that keep cuts clean.

## Three ways to combine

From chapter 2 you can place shapes. Real
objects need them combined, and
`examples/booleans.scad` holds the working
set:

```openscad
difference() {
    cube([60, 40, 10]);
    translate([12, 20, -1])
        cylinder(h = 12, r = 3);
    translate([48, 20, -1])
        cylinder(h = 12, r = 3);
}
```

- **`union()`** fuses its children into
  one solid: everything any of them
  occupies. (A bare sequence of shapes at
  the top level is already an implicit
  union; the explicit form matters inside
  other operations.)
- **`difference()`** takes its **first**
  child and subtracts every child after
  it. Order is everything: the thing being
  cut goes first, the cutters after.
  The specimen is a 60 × 40 × 10 mounting
  plate with two bolt holes.
- **`intersection()`** keeps only the
  volume **all** its children share. The
  specimen fuses two spheres with a union
  and then intersects the pair with a
  slab, leaving only the lens of plastic
  that lay inside both.

**Check:**

```console
$ openscad -o booleans.stl booleans.scad
booleans.stl: triangles=1840
  bbox x 0.00..105.97  y -11.97..40.00  z -5.00..10.00
  signed volume 30713.5
```

The plate's corner fixes x = 0 and
y = 40; the clipped lens reaches x ≈ 106
(sphere centres at 80 and 94, radius 12,
trimmed by the slab); the z floor of −5
is the clipping slab's underside. Volume
is positive — one closed scene, as
expected.

## Cutters stick out

Look again at the holes: the cylinders
run from z = −1 to z = 11 through a plate
that spans z = 0 to 10. That overshoot is
deliberate and it is the single most
useful boolean habit there is.

A cutter that ends **exactly flush** with
the face it pierces leaves the geometry
engine two surfaces occupying the same
plane — a coincidence it handles badly
and sometimes not at all, producing
paper-thin leftovers, speckles in the
preview, or a mesh a slicer complains
about. A cutter that pokes out a unit on
both sides cuts cleanly and unambiguously.

Rule of thumb: **every cutter extends at
least a fraction past both faces it
crosses.** The specimens overshoot by 1;
anything visible in the preview as a
stick-out is enough. The one cost is
honesty in reading your own code: a hole's
cylinder is taller than the plate, on
purpose, forever.

## Booleans are the slow part

Primitives are nearly free; putting them
*through each other* is where the render
time goes. Measured on the build machine,
the primitives scene rendered in about
0.3 s and this boolean scene — a holed
plate plus a clipped sphere-lens, all
curved cuts — in about 3.9 s. Curves cost more than flats, and
every cut is paid again each render.
Chapter 10 returns to this with the `$fn`
numbers; the working lesson here is
simpler: expect the difference-heavy
models to be the slow ones, and don't
blame the machine.

## A difference that subtracts nothing

Two failure shapes to recognise early,
because both render without complaint:

- **The cutter misses.** If the cutting
  shape doesn't actually overlap the
  target (a hole placed outside the
  plate), the result is the original
  solid, unchanged. No warning is owed
  to you, and none is given.
- **The cutter eats everything.** An
  oversized cutter leaves an empty model,
  which chapter 13 meets properly.

The defence is the same as everywhere in
this guide: measure the export — bounding
box and volume — and compare it with what
the code says should be there. A bolt
hole that never happened changes the
volume by nothing, and that nothing is
the tell.
