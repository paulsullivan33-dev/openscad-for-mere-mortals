# Recipes

**Scope:** the guide's specimens finished
and varied — the bracket end to end, and
the standard variations on the box, pot,
and tag. Every recipe names the file and
the check that proves it.

## An L bracket that bolts both ways

`examples/bracket.scad` — two legs of 50,
30 wide, 4 thick, two bolt holes per leg,
built exactly the way chapters 3–5 teach:
two slabs fused by `union`, holes cut by
`difference` with cutters sticking out on
both faces, hole positions driven from a
list by `for`:

```console
$ openscad -o bracket.stl bracket.scad
bracket.stl: triangles=548
  size 50.00 x 30.00 x 50.00   signed volume 11182.4
```

**Variations worth knowing:** move the
holes by editing the two lists
(`[14, leg - 12]`); gusset the corner by
adding a `hull()` or a diagonal slab
across the inside angle — an honest
weakness of the plain design is that the
corner is only as strong as the 4 mm
slabs meeting there.

## A box in a new size, without opening the file

The parametric point of chapter 8, as a
one-liner for the build script or the
shell:

```console
$ openscad -D width=120 -D depth=70 -D height=25 \
      -o box-120.stl examples/project-box.scad
```

Both `-D` overrides land, every derived
number follows, and the echoes report the
fit. (Run it as the check: the inside
opening should read 115.2 × 65.2.) For a
size you will make repeatedly, save it as
a parameter set instead — chapter 8's
`-p`/`-P` — and apply it by name.

## A plant pot that fits the sill

`examples/plant-pot.scad` is four numbers
deep: `top_r`, `bottom_r`, `pot_height`,
`wall`. A narrower, taller herb pot is
`-D top_r=32 -D bottom_r=24 -D pot_height=90`.
Two cautions the profile teaches:

- Keep `bottom_r` comfortably smaller
  than `top_r` minus nothing in
  particular — but keep the *inner*
  bottom radius (`bottom_r - wall`)
  greater than the drainage radius (8),
  or the floor's inner edge crosses the
  hole and the profile stops being a
  simple polygon.
- The drainage hole is 8 because the
  profile says 8; it is a parameter in
  everything but name. Promote it to a
  variable the day you need a second pot.

Measured default, for the record: 80
across, 70 tall, volume 43,202, 768
triangles.

## Name tags by the batch

The tag of chapter 9, made plural — the
shell loops, OpenSCAD personalises:

```console
$ for n in Ada Grace Lin; do
    openscad -D name="\"$n\"" -o "tag-$n.stl" \
        examples/name-tag.scad
  done
```

The quoting `\"$n\"` matters: `-D` values
are OpenSCAD expressions, so a string
needs its quotes *inside* the argument.
Each tag exports at the same 76 × 28 × 4.2
envelope with its own lettering (and its
own triangle count — chapter 9 measured
1,236 for Ada, 1,948 for Grace).

## A spacer, in one breath

The smallest useful parametric object —
a washer — to show how little a complete
model can be:

```openscad
difference() {
    cylinder(h = 4, r = 10, $fn = 48);
    translate([0, 0, -1])
        cylinder(h = 6, r = 4.2, $fn = 48);
}
```

Outer 20 across, hole 8.4 (a clearance
fit for an 8 bolt — clearance again, as a
named idea even when it is typed inline).
This one is small enough to type at the
command line's `openscad -o spacer.stl`
with the model in a file of six lines —
most real OpenSCAD work is closer to
this than to the box.
