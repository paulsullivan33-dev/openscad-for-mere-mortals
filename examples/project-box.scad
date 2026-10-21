// project-box.scad — a two-part project box with a lid.
// Every dimension is a variable, and the ones marked with
// the Customizer comments below can be changed from the
// OpenSCAD Customizer panel — or from the command line
// with -D, which chapter 8 does for real.

/* [Box dimensions] */
// Outside width of the box (x)
width = 80;          // [40:200]
// Outside depth of the box (y)
depth = 55;          // [30:150]
// Outside height of the box, without the lid (z)
height = 30;         // [15:100]
// Wall thickness everywhere
wall = 2.4;          // [1.2:0.4:5]
// How tall the lid's lip... rim is
lid_height = 6;      // [3:15]

/* [Hidden] */
$fn = 48;

// The shell: a solid block minus a smaller block that
// starts one wall up from the floor and pokes out of the
// top, leaving walls and a floor of thickness `wall`.
module shell(w, d, h, t) {
    difference() {
        cube([w, d, h]);
        translate([t, t, t])
            cube([w - 2 * t, d - 2 * t, h]);
    }
}

// The box itself.
shell(width, depth, height, wall);

// The lid, printed separately: a flat slab the size of
// the box, with a rim that drops INTO the shell's mouth.
// The rim is one clearance smaller than the inside, so
// the lid fits instead of wedging.
//
// Echoed so a command-line run reports the fit numbers
// (chapter 5 introduces echo).
inside_w = width - 2 * wall;
inside_d = depth - 2 * wall;
clearance = 0.4;
echo(str("inside opening: ", inside_w, " x ", inside_d));
echo(str("rim size: ", inside_w - 2 * clearance,
         " x ", inside_d - 2 * clearance));

translate([width + 10, 0, 0]) {
    cube([width, depth, 2.4]);
    translate([wall + clearance, wall + clearance, 2.4])
        cube([inside_w - 2 * clearance,
              inside_d - 2 * clearance,
              lid_height]);
}
