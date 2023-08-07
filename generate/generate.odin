package main

import "bindgen"

main :: proc() {
	options: bindgen.GeneratorOptions

	options.definePrefixes = {"WGPU_"}

	options.variableCase = .Snake

	options.pseudoTypePrefixes = {"WGPU"}

	options.enumValuePrefixes = {"_"}
	options.enumValueNameRemove = true

	options.functionPrefixes = {"wgpu"}
	options.functionCase = .Snake

	options.parserOptions = {
		ignoredTokens = {
			"WGPU_OBJECT_ATTRIBUTE",
			"WGPU_ENUM_ATTRIBUTE",
			"WGPU_STRUCTURE_ATTRIBUTE",
			"WGPU_FUNCTION_ATTRIBUTE",
			"WGPU_NULLABLE",
			"WGPU_EXPORT",
		},
	}

	bindgen.generate(
		packageName = "webgpu",
		foreignLibrary = "libwgpu_native",
		outputFile = "webgpu-generated.odin",
		headerFiles = {"./generate/webgpu-modified.h","./generate/wgpu.h"},
		options = options,
	)
}
