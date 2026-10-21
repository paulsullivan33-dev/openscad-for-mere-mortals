# Rounding and Blending

**Scope:** softening shapes on purpose —
`hull()` stretching a skin between
shapes, `minkowski()` rolling one shape
around another — what each costs, and
where each is the wrong tool.

## Sharp is the default

Primitives and booleans produce hard
edges. Real objects often want corners
off: for fingers, for strength, for looks.
OpenSCAD has no general "round this edge"
button — a genuine limit, stated plainly
in chapter 12 as well — but it has two
operations that round by construction.
Both are in `examples/rounded.scad`.

## `hull()`: a skin over the outside

`hull()` takes its children and returns
the smallest convex shape containing them
all — the shrink-wrap, the rubber band
around a handful of pegs.

```openscad
hull() {
    for (x = [6, 54], y = [6, 34])
        translate([x, y, 0])
            cylinder(h = 8, r = 6);
}
```

Four short posts at the corners of a
60 × 40 footprint, and hull wraps them
into a plate whose corners are
quarter-circles of radius 6 — the classic
"rounded rectangle, but solid" trick, and
the standard way to make a plate with
rounded corners in OpenSCAD. Convexity is
the catch: a hull cannot cave inward.
Ask it to wrap a C-shape and you get the
C's outer silhouette with the notch
filled in. Hulls join things and round
convex outlines; they do not carve.

## `minkowski()`: roll one shape around another

`minkowski()` adds two shapes together in
the mathematical sense: the result is
everywhere the second shape reaches when
its centre is walked along the first. A
cube minkowski-summed with a small sphere
is a cube with every edge and corner
rounded by the sphere's radius:

```openscad
minkowski() {
    cube([20, 12, 6]);
    sphere(r = 2);
}
```

Measured, the specimen comes out
24 × 16 × 10 overall — the cube's size
**plus the sphere's diameter in every
dimension**. That growth is the thing
everybody forgets exactly once: design
the inner shape smaller by the rounding
diameter, or the part arrives oversize.

And the cost warning this operation has
earned: minkowski is the most expensive
common operation in OpenSCAD. Rolling a
faceted sphere along every edge multiplies
geometry ferociously, and at high `$fn`
on a complex base shape it turns seconds
into minutes. At specimen scale the whole
rounded scene — hull plate and minkowski
block together — rendered in about 1.0 s
against the plain primitives scene's
0.3 s. Keep the rounding shape coarse
(low `$fn` on the sphere), round late,
and round only what needs it.

**Check:**

```console
$ openscad -o rounded.stl rounded.scad
rounded.stl: triangles=2696
  bbox x 0.00..97.00  y 0.00..40.00  z 0.00..10.00
```

x to 97 is the minkowski block (placed at
75, grown by 2 on each side of its 20
width: 73…97); the hull plate accounts
for the 60 × 40 at the left. The hull
plate's corners, measured at the
extremes, reach exactly the posts'
footprints — the skin adds nothing beyond
its pegs.

## Choosing

| Want | Reach for |
|---|---|
| rounded corners on a flat outline | `hull()` of corner posts, or `offset()` in 2D (chapter 7) |
| a solid rounded on all edges | `minkowski()` with a small sphere, budget the render |
| rounding on one specific edge of a complex part | neither, honestly — remodel, or accept the edge |

That third row is a real boundary of the
tool, not a gap in this guide: selective
filleting after the fact is what
boundary-representation modellers
(chapter 12) are built for.
