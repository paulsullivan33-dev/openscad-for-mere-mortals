// name-tag.scad — a luggage or toolbox tag with the name
// standing proud of the face. text() makes flat lettering;
// linear_extrude() gives it height. The name is a variable
// because names change: chapter 9 replaces it with -D.

/* [Tag] */
// The words on the tag
name = "Ada";
// Letter height in millimetres
letter_size = 14;    // [8:24]

/* [Hidden] */
$fn = 32;
tag_w = 76;
tag_d = 28;
tag_t = 3;      // tag thickness
letter_h = 1.2; // how far the letters stand proud

union() {
    // The tag itself, with a hanging hole cut at one end.
    difference() {
        cube([tag_w, tag_d, tag_t]);
        translate([7, tag_d / 2, -1])
            cylinder(h = tag_t + 2, r = 3);
    }
    // The letters, lying flat on the tag's face.
    translate([14, tag_d / 2, tag_t])
        linear_extrude(height = letter_h)
            text(name, size = letter_size,
                 font = "Liberation Sans:style=Bold",
                 halign = "left", valign = "center");
}
