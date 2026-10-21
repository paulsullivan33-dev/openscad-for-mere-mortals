# Variables and Modules

**Scope:** naming numbers so a model can
change its mind — variables, expressions,
and `module`, OpenSCAD's way of packaging
a piece of model for reuse — plus
`echo`, the print statement.

## Variables: one name per decision

A model written in raw numbers must be
edited in a dozen places to change one
idea. The project box (chapter 8) instead
starts like this:

```openscad
width = 80;
depth = 55;
height = 30;
wall = 2.4;
```

Every later line uses the names. Widen
the box and the cavity, the lid, and the
lid's rim all follow, because they were
never separate numbers — they were
computed from these.

Expressions are ordinary arithmetic, and
derived values deserve names too:

```openscad
inside_w = width - 2 * wall;
inside_d = depth - 2 * wall;
```

Two OpenSCAD behaviours surprise people
arriving from other languages; both are
by design:

- **Variables are set at compile time,
  and the last assignment in a scope
  wins** — for the whole scope, even for
  lines written *above* it. OpenSCAD
  variables behave less like a running
  program's memory and more like constants
  in a description. Loops don't
  accumulate into a variable the way
  imperative code does; `for` (below)
  exists to *place geometry*, not to
  tot things up.
- **Names starting with `$` are special**
  — `$fn`, `$fa`, `$fs` — and behave
  dynamically: a `$` variable set inside a
  module affects the geometry that module
  makes. Chapter 2's `$fn = 48;` is the
  everyday case.

## Modules: name a piece of model

A **module** packages geometry under a
name, with parameters:

```openscad
module shell(w, d, h, t) {
    difference() {
        cube([w, d, h]);
        translate([t, t, t])
            cube([w - 2 * t, d - 2 * t, h]);
    }
}

shell(width, depth, height, wall);
```

Calling `shell(...)` stamps the shape
with the given numbers. Call it again with
different ones and you have a second,
different box — the guide's bracket and
box both lean on this. Modules can take
defaults (`module shell(w, d, h, t = 2.4)`)
and can wrap **children**: a module that
uses `children()` applies itself to
whatever was nested under the call. That
is how the transformations of chapter 3
work under the hood, and how you write
your own.

`for` belongs in this chapter too: it is
geometry's loop.

```openscad
for (x = [14, leg - 12])
    translate([x, width / 2, -1])
        cylinder(h = thick + 2, r = hole_r);
```

— from the bracket: one statement, two
holes, at both listed positions.
`for (i = [0:2:10])` steps a range;
`for` over a list places a copy per item.

## `echo`: the model talks back

`echo()` prints a value while the model
evaluates. It changes nothing about the
geometry; it is how a parametric model
reports the numbers it derived — the ones
you didn't type and most need to check.

```console
$ openscad -o project-box.stl project-box.scad
ECHO: "inside opening: 75.2 x 50.2"
ECHO: "rim size: 74.4 x 49.4"
```

The box echoes its inside opening
(80 − 2×2.4 = 75.2 wide, as computed) and
the lid rim's size after clearance. Those
two lines are the fit of the lid, stated
by the model itself. Echoes appear on the
console during any export — and can be
captured as a file of their own
(`-o report.echo`), which is how build
scripts record what they made.

**Check:** any model in this guide can be
interrogated the same way — render it and
read what it says about itself before you
believe the picture. A model that echoes
the wrong number has told you the truth;
the bug is upstream, in the arithmetic.
