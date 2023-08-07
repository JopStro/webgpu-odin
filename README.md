# WebGPU odin
wgpu native bindings for the Odin programming language
Based on generated results from modified webgpu-native headers using [The Odin Binding Generator](https://github.com/Breush/odin-binding-generator)

Idomatic wrappers are added in [wrappers.odin](webgpu/wrappers.odin) for select procededures and a few helper functions are also added in [helpers.odin](webgpu/helpers.odin) - ChainedStruct(Out) constructors `link` and `chain` and a request callback constructor `request_cb`.
Additionally the subpackage [sdl](webgpu/sdl) contains a procedure for creating a surface from an sdl window.

I'm still getting familiar with WebGPU as I work on these bindings so some details may be subject to change.

# Examples
A couple simple examples exist in the [examples](examples) folder. 

I also reccomend checking out [LearnWebGPU for C++](https://eliemichel.github.io/LearnWebGPU/index.html) if you are new to programming with native webgpu as the bindings are close enough to the cpp api to still be helpful.
