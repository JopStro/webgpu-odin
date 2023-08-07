//+build darwin
package webgpu_sdl

import wgpu ".."
import "vendor:sdl2"

import NS "vendor:darwin/Foundation"
import CA "vendor:darwin/QuartzCore"

create_surface_from_window :: proc(window: ^sdl2.Window, instance: wgpu.Instance) -> (surface: wgpu.Surface) {
	window_system_info: sdl2.SysWMinfo
	sdl2.GetVersion(&window_system_info.version)
	sdl2.GetWindowWMInfo(window, &window_system_info)
	assert(window_system_info.subsystem == .COCOA, "Unexpexted Window System")
	ns_window := (^NS.Window)(window_system_info.info.cocoa.window)
	ns_window->contentView()->setWantsLayer(true)
	layer := CA.MetalLayer.layer()
	ns_window->contentView()->setLayer(layer)
	return wgpu.instance_create_surface(instance, {
		next_in_chain = wgpu.link(&wgpu.SurfaceDescriptorFromMetalLayer{
			layer = layer,
		}),
	})
}
