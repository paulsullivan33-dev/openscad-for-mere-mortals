// plant-pot.scad — a tapered plant pot with a drainage
// hole, made by spinning a 2D profile around the z axis.
// rotate_extrude() takes a flat shape drawn to the RIGHT
// of the axis (x >= 0) and sweeps it through 360 degrees.

/* [Pot dimensions] */
// Radius at the top rim
top_r = 40;          // [25:80]
// Radius at the base
bottom_r = 30;       // [20:60]
// Overall height
pot_height = 70;     // [40:120]
// Wall and floor thickness
wall = 2.4;          // [1.6:0.4:4]

/* [Hidden] */
$fn = 64;

// The profile is the pot's cross-section: one closed
// polygon that walks along the floor, up the outside,
// over the rim, back down the inside, and across the
// floor's top face. One polygon with a real thickness,
// so the pot is a single watertight solid. The profile
// starts and ends at r = 8 rather than r = 0 — the gap
// in the middle of the floor is the drainage hole.
rotate_extrude()
    polygon(points = [
        [8,            0],          // floor underside, inner edge
        [bottom_r,     0],          // floor underside, outer edge
        [top_r,        pot_height], // outside wall, up to the rim
        [top_r - wall, pot_height], // over the rim
        [bottom_r - wall, wall],    // inside wall, down to the floor
        [8,            wall]        // floor top face, back to the hole
    ]);
