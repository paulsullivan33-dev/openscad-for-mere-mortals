# Glossary

**2-manifold** — a mesh whose every edge
is shared by exactly two triangles and
whose surface has no holes: the formal
version of "watertight". Slicers want it;
a positive signed volume and CGAL's
`Simple: yes` are this guide's practical
proxies for it.

**Bounding box** — the smallest
axis-aligned box containing a model; the
first measurement to take of any export,
because a wrong one proves a wrong part.

**CGAL** — the geometry library OpenSCAD
uses for full renders and boolean
operations. When a render is slow, CGAL
is doing the slow part.

**Children** — the statements nested
under a transformation, boolean, or
module call; the geometry it operates on.

**CSG (constructive solid geometry)** —
modelling by combining primitive solids
with union, difference, and intersection.
The mathematical family OpenSCAD (and its
preview) belongs to.

**Customizer** — the GUI panel that turns
annotated variables (chapter 8) into
sliders and fields; its saved bundles are
parameter sets.

**`difference`** — the boolean that
subtracts: first child minus all the
rest.

**`echo`** — OpenSCAD's print statement;
reports values during evaluation and
changes no geometry.

**`$fn`** — the special variable setting
how many fragments approximate a full
circle. The smoothness dial, and the
price dial.

**Hull** — the smallest convex shape
containing its children; shrink-wrap as
an operation.

**`intersection`** — the boolean keeping
only the volume common to all children.

**`linear_extrude`** — pulling a 2D shape
straight up into a solid, optionally with
twist and taper.

**Manifold** — see 2-manifold.

**Minkowski sum** — one shape swept along
another's boundary; OpenSCAD's way of
rounding a solid in all dimensions at
once, at a price.

**Module** — a named, parameterised piece
of model; OpenSCAD's unit of reuse.

**`offset`** — growing or shrinking a 2D
outline by a fixed distance, rounding
outside corners as it goes.

**Parameter set** — a named bundle of
variable values in a JSON file, applied
with `-p`/`-P`, or saved by the
Customizer.

**Preview vs render** — the fast
approximate picture vs the full CGAL
evaluation; only the render is exported.

**Primitive** — a starting shape:
`cube`, `sphere`, `cylinder`, and their
2D kin.

**`rotate_extrude`** — sweeping a 2D
profile a full turn around the vertical
axis to make a surface of revolution.

**Slicer** — the software that turns a
mesh into printer instructions; owns
orientation, supports, and infill.

**STL / 3MF** — mesh file formats. STL:
triangles only, unitless, universal.
3MF: its successor, carrying units and
structure, and smaller for the same
geometry in this guide's measurement.

**Transformation** — `translate`,
`rotate`, `scale`, `mirror`, `color`: a
wrapper applying to the statement that
follows it.

**`undef`** — the value of a name that
was never defined; the quiet beginning
of chapter 13's cautionary tale.

**Union** — the boolean fusing its
children into one solid.

**Watertight** — the plumber's word for
2-manifold: a mesh with no gaps, ready
to be filled with infill by the slicer
without leaking.
