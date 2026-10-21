// transforms.scad — moving, turning, stretching, tinting.
// A transformation applies to the shape that follows it.
// Transformations nest: the innermost is applied first.

$fn = 32;

// One red cube, turned 45 degrees around the z axis.
rotate([0, 0, 45])
    color("red")
        cube([16, 16, 8]);

// The same cube twice more: moved, then stretched in x.
translate([30, 0, 0])
    color("green")
        cube([16, 16, 8]);

translate([55, 0, 0])
    scale([1.6, 1, 1])
        color("blue")
            cube([16, 16, 8]);

// A sphere and its mirror image across the x axis.
// mirror() flips everything under it — including the
// direction of the translate inside it — so the copy
// lands 18 to the LEFT of the group origin while the
// original sits at the origin. Watch for that when you
// read the bounding box in chapter 3. The pair sits in
// its own lane (y = 26) so nothing else interferes.
translate([92, 26, 8]) {
    sphere(r = 8);
    mirror([1, 0, 0])
        translate([18, 0, 0])
            sphere(r = 8);
}
