// syntax-error.scad — a genuine parse failure
// (chapter 13). The missing closing bracket means
// OpenSCAD cannot read the file at all: this one DOES
// stop the run, with an ERROR and a non-zero exit code.

cube([30, 20, 10);
