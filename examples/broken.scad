// broken.scad — a failure on purpose (chapter 13).
// Run it: OpenSCAD prints two WARNINGs, the unknown name
// becomes `undef`, the cube's size cannot be converted —
// and OpenSCAD falls back to a default 1 x 1 x 1 cube and
// exports THAT, with exit code 0. No error, just quietly
// the wrong object. The guide's main cautionary tale,
// kept small. (--hardwarnings turns it into a stop.)

// `widht` is a typo for `width`. OpenSCAD does not stop.
cube([widht, 20, 10]);
