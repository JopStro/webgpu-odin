//+build !darwin
package webgpu_sdl

import wgpu ".."
import "vendor:sdl2"

create_surface_from_window :: proc(window: ^sdl2.Window, instance: wgpu.Instance) -> (surface: wgpu.Surface) {
	window_system_info: sdl2.SysWMinfo
	sdl2.GetVersion(&window_system_info.version)
	sdl2.GetWindowWMInfo(window, &window_system_info)
	#partial switch window_system_info.subsystem {
	case .WAYLAND:
		surface = wgpu.instance_create_surface(instance, {
			next_in_chain = wgpu.link(&wgpu.SurfaceDescriptorFromWaylandSurface{
				display = window_system_info.info.wl.display,
				surface = window_system_info.info.wl.surface,
			}),
		})
	case .X11:
		surface = wgpu.instance_create_surface(instance, {
			next_in_chain = wgpu.link(&wgpu.SurfaceDescriptorFromXlibWindow{
				display = window_system_info.info.x11.display,
				window = cast(u32)window_system_info.info.x11.window,
			}),
		})
	case .WINDOWS:
		surface = wgpu.instance_create_surface(instance, {
			next_in_chain = wgpu.link(&wgpu.SurfaceDescriptorFromWindowsHWND{
				hwnd = window_system_info.info.win.window,
				hinstance = window_system_info.info.win.hinstance,
			}),
		})
	}
	return
}
