// primitives.scad — the three solid building blocks.
// Every measurement below is in the file's own units;
// OpenSCAD itself has no units (chapter 1 explains).

// A box: width (x), depth (y), height (z), in that order.
cube([30, 20, 10]);

// A ball. r is the radius; it sits centred on the origin,
// so half of it is below z=0 until something moves it.
translate([45, 0, 8])
    sphere(r = 8);

// A can. h is height, r1 the bottom radius, r2 the top
// radius — r1 != r2 makes a cone or a tapered pot wall.
// $fn is how many flat sides approximate the curve:
// the preview default is coarse; here 48 is requested.
translate([70, 0, 0])
    cylinder(h = 16, r1 = 9, r2 = 6, $fn = 48);
