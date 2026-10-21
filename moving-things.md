# Moving Things

**Scope:** `translate`, `rotate`,
`scale`, `mirror`, and `color` — the
transformations that place shapes where
they belong — and the one rule that
governs them all.

## The rule: a transformation owns what follows it

A transformation is not a command that
acts on a shape. It is a wrapper: it
applies to **the thing written after it**,
and to nothing else.

```openscad
translate([45, 0, 8])
    sphere(r = 8);
```

The semicolon is the boundary. Everything
up to the next `;` belongs to the
transformation; the next statement starts
unmoved. To move several shapes together,
group them in braces and transform the
group:

```openscad
translate([92, 26, 8]) {
    sphere(r = 8);
    // ...more shapes, all carried along
}
```

Transformations also **nest**, and they
compose inside-out: in
`translate(...) rotate(...) cube(...)`,
the cube is rotated first, then the result
is translated. Read nested transformations
from the shape outward.

## The five working transformations

All five are exercised in
`examples/transforms.scad` on one repeated
cube and a pair of spheres:

| Transformation | What it does |
|---|---|
| `translate([x, y, z])` | moves by the given amounts |
| `rotate([x, y, z])` | turns by degrees around each axis |
| `scale([x, y, z])` | stretches by factors (1 = unchanged) |
| `mirror([x, y, z])` | reflects across the plane normal to the vector |
| `color("name")` or `color([r,g,b])` | tints for preview and PNG; no effect on STL geometry |

Three of them have the classic beginner
surprises:

**Rotation is about the origin, in
degrees, right-hand rule.** The specimen's
first cube is `rotate([0, 0, 45])` on a
cube that starts at the origin, so the
cube swings around the origin like a door
on its hinge — its bounding corner reaches
x = −11.31 in the measured export. If you
wanted it spun in place, you centre it
first, spin, then move it. Order is the
whole game.

**Scale multiplies coordinates, including
positions under it.** `scale([1.6, 1, 1])`
on a 16-wide cube makes a 25.6-wide cube.
Scale a *group* and the children's
positions are stretched too — usually what
you want, always worth a thought.

**Mirror flips the world under it —
including directions.** The specimen's
sphere pair shows the measured truth:

```openscad
translate([92, 26, 8]) {
    sphere(r = 8);
    mirror([1, 0, 0])
        translate([18, 0, 0])
            sphere(r = 8);
}
```

The inner `translate([18, 0, 0])` reads as
"18 to the right", but it sits *inside*
`mirror([1, 0, 0])`, so the copy lands 18
to the **left**: spheres at x = 92 and
x = 74, which is what the export measures
(overall scene x −11.31…99.96, the 99.96
being 92 plus the faceted radius).
Mirroring a part to make its left-handed
twin is exactly what `mirror` is for —
just remember it reverses every direction
and every rotation inside it, not only
the one you were thinking about.

**Check:** the whole specimen, measured:

```console
$ openscad -o transforms.stl transforms.scad
transforms.stl: triangles=1930
  bbox x -11.31..99.96  y 0.00..33.96  z 0.00..15.96
```

Every extreme in that box belongs to a
known shape: −11.31 the rotated cube's
corner, 99.96 the right-hand sphere,
33.96 the spheres' lane (y = 26 + radius),
15.96 the sphere tops sitting at z = 8.
Transformations are where models quietly
go wrong; the bounding box is how you
catch them in the act.

A last word on `color`: it is real and
useful — for telling parts apart on
screen and in PNG pictures (chapter 10).
It is **not** part of the geometry. An
STL exported from a coloured model is the
same grey solid as from an uncoloured one.
