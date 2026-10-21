# What OpenSCAD Is

**Scope:** what kind of tool this is, the
one idea everything else stands on — the
model *is* a program — what a render
really does, the units question, and the
lab you will practise on.

## A modeller where you write the model

Most 3D modelling tools hand you a lump of
digital clay and a set of sculpting tools.
**OpenSCAD** hands you a text editor. You
write instructions —

```openscad
cube([30, 20, 10]);
```

— and OpenSCAD works out the solid those
instructions describe: in this case a box
30 wide, 20 deep, 10 tall. Change the
numbers, re-run, and the box changes.
Nothing was dragged with a mouse, so
nothing is approximate unless you wrote it
that way. A model in OpenSCAD is a
**program**, and everything good and bad
about this tool follows from that:

- Dimensions are **numbers in the text**,
  so they can be calculated, named, and
  reused — chapters 5 and 8 build the
  whole guide's main model out of that
  idea.
- A model is a file you can keep in version
  control, diff, email, and regenerate
  years later.
- There is nothing to click wrong — but
  there is plenty to type wrong, and
  chapter 13 shows the particular way
  OpenSCAD fails to tell you.

The trade is real: organic shapes — a
face, a tree, a hand — are painful to
describe in arithmetic. OpenSCAD is for
the other kind of object: brackets, boxes,
pots, tags, adapters. Things with
measurements. If the thing you want has a
drawing with numbers on it, this is your
tool; chapter 12 is honest about where its
world ends.

## Preview, render, export

Working with a model has three stages, and
keeping them apart prevents most beginner
confusion:

- **Preview** is the fast, approximate
  picture the graphical application shows
  while you edit. It is drawn with
  shortcuts and is *not* a proof the solid
  is sound.
- **Render** is the real computation: the
  program is fully evaluated into exact
  geometry (by a geometry engine called
  CGAL). This is the step that can be slow,
  and the one whose results an export
  contains.
- **Export** writes the rendered geometry
  to a file — usually **STL** for 3D
  printing, or 3MF, or a PNG picture of the
  model for sharing.

This guide works at the command line, where
the three stages look like this:

```console
$ openscad -o plant-pot.stl plant-pot.scad
```

That single command renders
`plant-pot.scad` and writes the STL.
Everything in the chapters was verified
this way. The graphical application — its
editor, its preview, its Customizer panel —
is described where it matters but was not
available on the build machine, and
`criteria.md` keeps that ledger.

**Check:** your version, before anything
else:

```console
$ openscad --version
OpenSCAD version 2021.01
```

2021.01 is the current stable release and
the version every capture in this guide
comes from. (Development snapshots exist;
their behaviour can differ in details this
guide doesn't cover.)

## The units are yours

OpenSCAD numbers are **unitless**. A cube
of `[30, 20, 10]` is 30 *somethings*. The
convention — followed by slicers, which
read STL files as millimetres — is that
one unit is **one millimetre**, and every
model in this guide is written that way.
Model in millimetres, and the file you
hand to a printer comes out the size you
meant. Model in anything else and the
printer will still assume millimetres,
which is how a "30-inch" bracket arrives
as a 30 mm one.

## The lab

`examples/` holds the specimens, each a
small generic household object:

- `primitives.scad`, `transforms.scad`,
  `booleans.scad`, `rounded.scad`,
  `flat.scad` — one language idea each;
- `project-box.scad` — the main build, a
  parametric box with a lid;
- `plant-pot.scad`, `name-tag.scad`,
  `bracket.scad` — complete small objects;
- `fn-demo.scad` — one sphere, for the
  smoothness-versus-speed experiment;
- `broken.scad` and `syntax-error.scad` —
  failures on purpose.

`examples/lab-notes.txt` lists each
specimen and what its numbers are. Every
name is invented and every object is
generic: a box, a pot, a tag, a bracket.
