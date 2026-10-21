# Words in Plastic

**Scope:** `text()` — real lettering as
geometry — laid on a name tag with
`linear_extrude`, and the font facts that
decide what your letters look like.

## `text()` makes an outline

`text()` is a 2D shape like `circle` or
`square`: it produces the outlines of its
string, which you then extrude, cut, or
offset like any other flat geometry.
Raised lettering is an extruded union;
engraved lettering is the same text used
as a cutter in a `difference`.

The specimen, `examples/name-tag.scad`,
is a 76 × 28 × 3 tag with a hanging hole
and the name standing proud of the face:

```openscad
translate([14, tag_d / 2, tag_t])
    linear_extrude(height = letter_h)
        text(name, size = letter_size,
             font = "Liberation Sans:style=Bold",
             halign = "left", valign = "center");
```

The points that matter:

- **`size`** is roughly the font's em
  size in units — capital height comes
  out smaller than the number. Measure
  the result (below) instead of assuming.
- **`halign` / `valign`** anchor the
  string: `"center"` both ways is the
  usual choice for a label centred on a
  known point.
- **The name is a variable** (`name =
  "Ada"`), so the whole tag re-personalises
  from the command line:

```console
$ openscad -o name-tag.stl name-tag.scad
name-tag.stl: triangles=1236   size 76.00 x 28.00 x 4.20
$ openscad -D name="Grace" -o name-tag-grace.stl name-tag.scad
name-tag-grace.stl: triangles=1948   size 76.00 x 28.00 x 4.20
```

Same tag, same 4.20 total height in both
(3 of tag + 1.2 of letter); the lettering
is the only difference, and it is not
free: "Grace" carries 712 more triangles
than "Ada" and its render took about
4.8 s against 1.8 s on the build machine.
Text is curves all the way down, and the
geometry engine pays for every letter.

**Check:** letters that overflow the tag
are the common failure — a longer name at
the same size walks off the edge, and
nothing warns you. The bounding box of
the *letters alone* is the honest check;
the quick version is to export the name
as its own run (comment the tag out, or
echo the text metrics via `echo` in your
own models) before committing to the
full render.

## Fonts: the honest paragraph

`font = "Liberation Sans:style=Bold"` in
the specimen names a font **and** style
in the `family:style=...` spelling. The
build machine's font library listed
Liberation Sans (it is the font OpenSCAD
installers commonly bundle, and the
usual default when no font is named).

But fonts live on the machine, not in
the `.scad` file. The same model rendered
on a computer without Liberation Sans
falls back to something else — silently —
and the tag comes out in different
lettering with different widths, possibly
overflowing. Three working rules:

- Name the font explicitly, as the
  specimen does; an unnamed font is
  whatever the machine feels like.
- Treat a model with text as
  machine-specific until you have
  rendered it on the machine that matters.
- If a design must travel, the letters
  are the part to re-check first.

Which fonts a given machine offers is
listed by the GUI's font dialog (and by
`fc-list` on Linux); the roster differs
across Windows, Mac, and Linux in exactly
the way operating-system fonts always
have. This guide verified its specimen
against Liberation Sans on Linux only.
