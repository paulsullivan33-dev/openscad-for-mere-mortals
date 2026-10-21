# The Neighbours

**Scope:** where OpenSCAD sits among the
other ways to get a model — what each
neighbour does better, what it gives up,
and how to choose without religion.

## The map

| Tool | The model is… | Strong at | Weak at |
|---|---|---|---|
| **OpenSCAD** | a program you write | measured parts, parametric variants, scripted exports | organic shapes, after-the-fact fillets, huge assemblies |
| **Tinkercad** | blocks you drag | first contact, classrooms, quick mashups | precision, reuse, anything you must reproduce exactly |
| **FreeCAD** | a sketch-and-feature history | real engineering CAD, constraints, assemblies, STEP export | a steeper learning curve than everything else on this list |
| **Fusion 360** | a cloud feature history | polished CAD+CAM in one place | licensing terms that change; your work lives in someone else's cloud |
| **Blender** | a mesh you sculpt | art, animation, organic form | dimensional accuracy is a discipline there, not a default |
| **CadQuery / Build123d** | a Python program | OpenSCAD's scriptability with a real CAD kernel (fillets, STEP) | a smaller community; Python fluency required |

## Honest placements

**Against the GUI CAD tools**, OpenSCAD's
deal is text. A FreeCAD model is a tree
of sketches and features — richer than
anything in this guide: it can fillet one
chosen edge, constrain a sketch so a hole
stays centred *by rule*, and export STEP
files that machine shops speak. For a
one-off artistic object that power is
worth its learning curve. For "the same
box in twelve sizes, exported overnight",
the program wins: OpenSCAD models are
diffable, generatable, and runnable
without a human at a mouse, which is why
this guide exists.

**CadQuery and Build123d** are the
neighbours a reader of this guide should
know exist. They are OpenSCAD's true
siblings — models as code — built on an
industrial geometry kernel. Selective
fillets and chamfers, proper STEP export,
and curved surfaces that are genuinely
round rather than faceted all live there.
The cost is leaving the tiny, stable,
learnable-in-a-weekend language this
guide teaches for a larger Python
ecosystem. If you outgrow OpenSCAD, that
is the direction you outgrow *into*.

**Blender** is not a rival but a
different trade: it sculpts meshes
directly, superbly, and its numbers mean
less by default. People do print precise
parts from Blender; they work at it.
Nothing in this guide needs sculpting.

**Tinkercad** deserves its good name:
it is where many people first put a hole
through a block, in a browser, in five
minutes. Its ceiling is reproducibility —
a Tinkercad design cannot be regenerated
from a script or meaningfully versioned —
and readers who feel that ceiling are
exactly OpenSCAD's audience.

## The slicer is a neighbour too

Whatever makes the model, a **slicer**
(Cura, PrusaSlicer, Bambu Studio and
kin) turns it into printer instructions
and owns orientation, supports, infill,
and the wall-count decisions chapter 10
deliberately left there. Fluent OpenSCAD
plus a fluent slicer is the whole home
pipeline; this guide covers the first
half and says so.
