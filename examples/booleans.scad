// booleans.scad — adding and cutting solids.
// union()        keep everything from every shape
// difference()   first shape minus all the shapes after it
// intersection() keep only where all shapes overlap

$fn = 48;

// A mounting plate with two bolt holes: a box, minus two
// cylinders. The cutters stick out above and below the
// plate (z from -1 to 11 for a 10-thick plate) so the
// holes cut cleanly — chapter 4 explains why.
difference() {
    cube([60, 40, 10]);
    translate([12, 20, -1])
        cylinder(h = 12, r = 3);
    translate([48, 20, -1])
        cylinder(h = 12, r = 3);
}

// Beside it, everything at once: two overlapping balls
// fused by union, then intersected with a slab so only
// the shared lens inside the slab survives.
translate([80, 0, 0])
    intersection() {
        union() {
            sphere(r = 12);
            translate([14, 0, 0])
                sphere(r = 12);
        }
        translate([-14, -14, -5])
            cube([56, 28, 10]);
    }
