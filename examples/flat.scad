// flat.scad — 2D shapes that become solids (chapter 7).
// On the left, a pentagon prism that twists as it rises:
// linear_extrude() with twist rotates the flat shape
// between its bottom and its top, around the 2D origin —
// so the profile is drawn centred on the origin first,
// extruded, and only then moved as a finished solid.
// (Draw it off-centre instead and the twist swings it
// around the axis like a bucket on a rope.)
//
// On the right, a square whose corners were rounded by
// offset() before extruding: offset grows (or shrinks) a
// 2D outline by a fixed distance, the easy way to round
// flat corners.

// A five-sided prism, twisted a quarter turn over 30.
translate([14, 14, 0])
    linear_extrude(height = 30, twist = 90)
        circle(r = 12, $fn = 5);

// A 30 x 20 plate with 3-radius corners, 4 thick:
// offset adds the radius on every side, so the finished
// plate is 36 x 26.
translate([34, 2, 0])
    linear_extrude(height = 4)
        offset(r = 3)
            square([30, 20]);
