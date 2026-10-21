// rounded.scad — softening corners two ways.
// hull() stretches a skin over the OUTSIDE of its shapes:
// cylinders at the four corners make a plate whose edges
// are quarter-circles. minkowski() rolls one shape around
// another and keeps the swept volume — lovely, and slow;
// chapter 6 measures both.

$fn = 48;

// A plate with rounded corners, built from four posts.
hull() {
    for (x = [6, 54], y = [6, 34])
        translate([x, y, 0])
            cylinder(h = 8, r = 6);
}

// A small block with every edge rounded, the minkowski
// way: a smaller cube plus a ball of radius 2.
// The result is 24 x 16 x 10 overall: the cube carries
// the size minus the ball's diameter in each dimension.
translate([75, 10, 2])
    minkowski() {
        cube([20, 12, 6]);
        sphere(r = 2);
    }
