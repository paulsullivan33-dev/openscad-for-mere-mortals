// bracket.scad — an L-shaped shelf bracket: one flat leg
// for the wall, one for the shelf, two bolt holes in each.
// Built as two slabs joined by union(), then holed.

/* [Bracket] */
// Length of each leg
leg = 50;            // [30:90]
// Width of the bracket (into the page, y)
width = 30;          // [20:50]
// Slab thickness
thick = 4;           // [3:6]
// Bolt hole radius
hole_r = 2.6;        // [2:0.2:4]

/* [Hidden] */
$fn = 32;

difference() {
    union() {
        // Vertical leg (stands in the x-z plane).
        cube([thick, width, leg]);
        // Horizontal leg (lies in the x-y plane).
        cube([leg, width, thick]);
    }
    // Two holes through the vertical leg.
    for (z = [14, leg - 12])
        translate([-1, width / 2, z])
            rotate([0, 90, 0])
                cylinder(h = thick + 2, r = hole_r);
    // Two holes through the horizontal leg.
    for (x = [14, leg - 12])
        translate([x, width / 2, -1])
            cylinder(h = thick + 2, r = hole_r);
}
