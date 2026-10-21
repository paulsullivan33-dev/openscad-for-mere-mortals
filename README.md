# OpenSCAD for Mere Mortals

Most 3D modelling tools hand you digital
clay. **OpenSCAD** hands you a text
editor: the model is a program —

```openscad
cube([30, 20, 10]);
```

— and the solid is what the program
describes. That one idea is the whole
tool. Dimensions become numbers you can
name, compute with, and change in one
place; a design becomes a file you can
keep, diff, and regenerate years later;
and a box in twelve sizes is a loop, not
an afternoon. The price is the other
half of the idea: faces, trees, and
teapots shaped like teapots are miserable
to write as arithmetic. OpenSCAD is for
objects with measurements — brackets,
boxes, pots, tags, adapters — and this
guide builds exactly those.

The lab is a shelf of small specimens in
`examples/`: one per language idea, and
four finished objects — a parametric
project box with a lid, a plant pot spun
from a flat profile, a name tag with
raised lettering, and an L bracket. Two
more specimens are failures on purpose,
because OpenSCAD's characteristic failure
is not stopping: it exports the wrong
object with a warning and a success code,
and chapter 13 makes you watch it happen.

A note on how this guide was verified.
OpenSCAD 2021.01 was on the build
machine, and every command quoted was
run headless against the specimens: the
exports were measured (triangles,
bounding box, signed volume), the echoes
recorded, the renders timed, and the
failure fixtures sprung. The graphical
application was not available headless,
so the guide works at the command line
throughout and says plainly which parts
are documented-only; `criteria.md` keeps
the full ledger.

## What this guide covers

- [**What OpenSCAD is**](what-openscad-is.md) —
  the model as a program; preview, render,
  export; the units convention; the lab
- [**First shapes**](first-shapes.md) —
  `cube`, `sphere`, `cylinder`, where each
  sits when created, and the `$fn` dial
- [**Moving things**](moving-things.md) —
  `translate`, `rotate`, `scale`,
  `mirror`, `color`, and the rule that a
  transformation owns what follows it
- [**Adding and cutting**](adding-and-cutting.md) —
  `union`, `difference`, `intersection`,
  and why cutters stick out
- [**Variables and modules**](variables-and-modules.md) —
  naming numbers, packaging geometry,
  and `echo`, the model's own report
- [**Rounding and blending**](rounding-and-blending.md) —
  `hull()` and `minkowski()`, what each
  costs, and where each is the wrong tool
- [**Flat to solid**](flat-to-solid.md) —
  2D shapes, `offset`, `linear_extrude`
  with a twist that pivots on the origin,
  and `rotate_extrude` spinning a pot
  profile
- [**The parametric box**](the-parametric-box.md) —
  the main build whole: shell, lid,
  clearance, Customizer annotations, and
  changing the model with `-D` and
  parameter sets
- [**Words in plastic**](words-in-plastic.md) —
  `text()` as geometry, raised lettering
  on a name tag, and the honest truth
  about fonts travelling between machines
- [**From screen to printer**](from-screen-to-printer.md) —
  STL, 3MF, and PNG exports; measuring an
  export instead of admiring it; why a
  rendered model is not yet a printable
  one; the `$fn` experiment, priced
- [**Recipes**](recipes.md) — the bracket
  finished, boxes and pots resized from
  the command line, name tags by the
  batch, a six-line spacer
- [**The neighbours**](the-neighbours.md) —
  FreeCAD, Fusion 360, Tinkercad,
  Blender, and the code-first siblings
  CadQuery and Build123d, placed honestly
- [**Troubleshooting**](troubleshooting.md) —
  the export that succeeded wrongly,
  warnings vs errors, empty renders,
  missing holes, headless pictures, and
  renders that take forever
- [**Glossary**](glossary.md) — the
  terms, collected in one place

## What it doesn't cover

Sculpting and organic modelling — the
neighbours chapter points at the tools
built for it. Assemblies of many parts
with mates and motion: real CAD owns
that. The full language — `let`, recursion
beyond a mention, the 2D subdivision and
import machinery (`import()`, DXF/SVG
pipelines), animation, and the
development snapshots' experimental
features are out of scope; the guide
teaches the working core that the
specimens exercise. Printing itself —
slicing, materials, machine tuning —
belongs to the printer guides; this one
ends with a measured, watertight file
and honest notes about what happens next.

## How to use this guide

Read chapter 1, then keep a terminal open
from chapter 2 on: every specimen can be
exported and measured as its chapter
describes, and the chapters' numbers are
the specimens' numbers, so yours should
match. Change the specimens as you go —
a parametric model that you have broken
and repaired teaches more than one you
have only read — and keep `broken.scad`
for last, or for the day a real model
exports suspiciously well.
