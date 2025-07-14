# My New Project

Simplest cube creation / modification / removal for https://forum.castle-engine.io/t/drawing-many-cubes-faster/ .

Please note that this doesn't try to be fast / optimal. And all cubes here have different size and color. E.g.

- This example doesn't try to group cubes and render them using `TCastleTransformReference`. In many actual cases, you don't have 1000 different objects, you have 1000 instances of the few same object(s), and you can optimize it with `TCastleTransformReference`.

- It doesn't use LOD.

- It doesn't use batching.

- It doesn't instantiate a design using `TCastleComponentFactory` mentioned in that thread. In many practical cases, `TCastleBox` will not be enough, instead: instantiate designs with https://castle-engine.io/reuse_design and/or create `TCastleScene` with generated node graph inside.

- Here, each cube is separate `TCastleBox` instance (which is internally separate `TCastleScene` instance). This is sometimes enough, but sometimes you can put multiple cubes in one scene.

It's just a simplest example how to easily create / modify / remove many cubes.

It uses https://castle-engine.io/occlusion_culling . Though it doesn't have a city-on-foot view that would best benefit from occlusion culling. Your view may be better for occlusion culling.

Using [Castle Game Engine](https://castle-engine.io/).

## Building

Compile by:

- [CGE editor](https://castle-engine.io/editor). Just use menu items _"Compile"_ or _"Compile And Run"_.

- Or use [CGE command-line build tool](https://castle-engine.io/build_tool). Run `castle-engine compile` in this directory.

- Or use [Lazarus](https://www.lazarus-ide.org/). Open in Lazarus `many_cubes_standalone.lpi` file and compile / run from Lazarus. Make sure to first register [CGE Lazarus packages](https://castle-engine.io/lazarus).

- Or use [Delphi](https://www.embarcadero.com/products/Delphi). Open in Delphi `many_cubes_standalone.dproj` file and compile / run from Delphi. See [CGE and Delphi](https://castle-engine.io/delphi) documentation for details.