// fn-demo.scad — one ball, nothing else (chapter 10).
// Render it with -D fn=8, then fn=32, then fn=128 and
// compare the STL triangle counts and the render times:
// $fn is the dial between "fast and faceted" and
// "smooth and slow".

fn = 32; // override from the command line with -D fn=...

sphere(r = 20, $fn = fn);
