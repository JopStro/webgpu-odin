package webgpu_example

import "vendor:sdl2"
import wgpu "../../webgpu"
import wsdl "../../webgpu/sdl"
import "core:fmt"
import "core:runtime"

Vertex :: struct {
	position: [2]f32,
	color: [3]f32,
}

Index :: u16

main :: proc() {
	WINDOW_WIDTH :: 800
	WINDOW_HEIGHT :: 600

	vertex_data := []Vertex {
		{{-0.5, -0.5}, {1.0, 0.0, 0.0}},
		{{+0.5, -0.5}, {0.0, 1.0, 0.0}},
		{{+0.5, +0.5}, {1.0, 1.0, 1.0}},
		{{-0.5, +0.5}, {0.0, 0.0, 1.0}},
	}

	index_data := []Index {
		0, 1, 2,
		0, 2, 3,
	}

	assert(sdl2.Init({.VIDEO}) == 0, "Could not initialize sdl")
	defer sdl2.Quit()

	window := sdl2.CreateWindow("WebGPU Square",  sdl2.WINDOWPOS_CENTERED, sdl2.WINDOWPOS_CENTERED, WINDOW_WIDTH, WINDOW_HEIGHT, {})
	assert(window != nil, "Could not create window")
	defer sdl2.DestroyWindow(window)

	instance := wgpu.create_instance({})
	assert(instance != nil, "Could not create instance")
	defer wgpu.instance_release(instance)

	surface := wsdl.create_surface_from_window(window, instance)
	assert(surface != nil, "Could not create surface")
	defer wgpu.surface_release(surface)

	adapter: wgpu.Adapter
	wgpu.instance_request_adapter(instance, wgpu.RequestAdapterOptions{
		compatible_surface = surface,
	},  wgpu.request_cb(wgpu.RequestAdapterCallback), &adapter)
	assert(adapter != nil, "Could not request adapter")

	supported_limits := wgpu.adapter_get_limits(adapter)

	device: wgpu.Device
	wgpu.adapter_request_device(adapter, {
		label = "My Device",
		required_limits = &wgpu.RequiredLimits{
			limits = {
				max_vertex_attributes = 2,
				max_vertex_buffers = 1,
				max_buffer_size = cast(u64)len(vertex_data) * size_of(Vertex),
				max_vertex_buffer_array_stride = size_of(Vertex),
				max_inter_stage_shader_components = 3,
				min_storage_buffer_offset_alignment = supported_limits.limits.min_storage_buffer_offset_alignment,
				min_uniform_buffer_offset_alignment = supported_limits.limits.min_uniform_buffer_offset_alignment,
			},
		},
		default_queue = {
			label = "The default queue",
		},
	}, wgpu.request_cb(wgpu.RequestDeviceCallback), &device)
	assert(device != nil, "Could not request device")
	defer wgpu.device_release(device)

	wgpu.device_set_uncaptured_error_callback(device, proc "c" (type: wgpu.ErrorType, message: cstring, _: rawptr) {
		context = runtime.default_context()
		fmt.print("Uncaptured device error: ")
		if message != nil do fmt.println(message)
		else do fmt.println("type", type)
	}, nil)

	queue := wgpu.device_get_queue(device)
	defer wgpu.queue_release(queue)

	color_format := wgpu.surface_get_preferred_format(surface,adapter)
	swap_chain := wgpu.device_create_swap_chain(device, surface, {
		width = WINDOW_WIDTH,
		height = WINDOW_HEIGHT,
		format = color_format,
		usage = .RenderAttachment,
		present_mode = .Fifo,
	})
	defer wgpu.swap_chain_release(swap_chain)

	shader := wgpu.device_create_shader_module(device, {
		next_in_chain = wgpu.link(&wgpu.ShaderModuleWGSLDescriptor{
			code = #load("../shader.wgsl", cstring),
		}),
	})
	defer wgpu.shader_module_release(shader)

	vertex_attributes := []wgpu.VertexAttribute{
		{
			shader_location = 0,
			format = .Float32x2,
			offset = cast(u64)offset_of(Vertex, position),
		},
		{
			shader_location = 1,
			format = .Float32x3,
			offset = cast(u64)offset_of(Vertex, color),
		},
	}

	pipeline := wgpu.device_create_render_pipeline(device, {
		vertex = {
			module = shader,
			buffer_count = 1,
			buffers = &wgpu.VertexBufferLayout{
				attribute_count = len(vertex_attributes),
				attributes = raw_data(vertex_attributes),
				array_stride = u64(size_of(Vertex)),
				step_mode = .Vertex,
			},
			entry_point = "vs_main",
		},
		primitive = {
			topology = .TriangleList,
			strip_index_format = .Undefined,
			front_face = .CCW,
			cull_mode = .None,
		},
		fragment = &wgpu.FragmentState{
			module = shader,
			entry_point = "fs_main",
			target_count = 1,
			targets = &wgpu.ColorTargetState{
				format = color_format,
				blend = &wgpu.BlendState{
					color = {
						src_factor = .SrcAlpha,
						dst_factor = .OneMinusSrcAlpha,
						operation = .Add,
					},
					alpha = {
						src_factor = .Zero,
						dst_factor = .One,
						operation = .Add,
					},
				},
				write_mask = .All,
			},
		},
		multisample = {
			count = 1,
			mask = 0xffffffff,
			alpha_to_coverage_enabled = false,
		},
	})
	defer wgpu.render_pipeline_release(pipeline)

	vertex_buffer := wgpu.device_create_buffer(device, {
		size = u64(len(vertex_data) * size_of(Vertex)),
		usage = .CopyDst | .Vertex,
	})
	defer wgpu.buffer_release(vertex_buffer)
	wgpu.queue_write_buffer(queue, vertex_buffer, 0, vertex_data)

	index_buffer := wgpu.device_create_buffer(device, {
		size = u64(len(index_data) * size_of(Index)),
		usage = .CopyDst | .Index,
	})
	defer wgpu.buffer_release(index_buffer)
	wgpu.queue_write_buffer(queue, index_buffer, 0, index_data)

	loop: for {
		for event: sdl2.Event; sdl2.PollEvent(&event); {
			#partial switch event.type {
				case .QUIT: break loop
			}
		}

		next_texture := wgpu.swap_chain_get_current_texture_view(swap_chain)
		if next_texture == nil {
			fmt.println("Cannot acquire next swap chain texture")
			break loop
		}
		defer wgpu.texture_view_release(next_texture)

		encoder := wgpu.device_create_command_encoder(device, {
			label = "My command encoder",
		})
		defer wgpu.command_encoder_release(encoder)

		render_pass := wgpu.command_encoder_begin_render_pass(encoder, {
			color_attachment_count = 1,
			color_attachments = &wgpu.RenderPassColorAttachment{
				view = next_texture,
				load_op = .Clear,
				store_op = .Store,
				clear_value = {0.05, 0.05, 0.05, 1.0},
			},
		})
		defer wgpu.render_pass_encoder_release(render_pass)

		wgpu.render_pass_encoder_set_pipeline(render_pass, pipeline)

		wgpu.render_pass_encoder_set_vertex_buffer(render_pass, 0, vertex_buffer, 0, cast(u64)len(vertex_data) * size_of(Vertex))
		wgpu.render_pass_encoder_set_index_buffer(render_pass, index_buffer, .Uint16, 0, u64(len(index_data)) * size_of(Index))
		wgpu.render_pass_encoder_draw_indexed(render_pass, cast(u32)len(index_data), 1, 0, 0, 0)

		wgpu.render_pass_encoder_end(render_pass)

		command := wgpu.command_encoder_finish(encoder, {
			label = "Command buffer",
		})
		defer wgpu.command_buffer_release(command)

		wgpu.queue_submit(queue, {command})

		wgpu.swap_chain_present(swap_chain)
	}
}
