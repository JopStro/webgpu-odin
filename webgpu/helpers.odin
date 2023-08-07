package webgpu

import "core:intrinsics"
import "core:fmt"
import "core:runtime"

link :: proc(l: ^$T) -> ^T where intrinsics.type_is_subtype_of(T, ChainedStruct) || intrinsics.type_is_subtype_of(T, ChainedStructOut) {
    when T == SurfaceDescriptorFromMetalLayer {
        l.s_type = .SurfaceDescriptorFromMetalLayer
    } else when T == SurfaceDescriptorFromWindowsHWND {
        l.s_type = .SurfaceDescriptorFromWindowsHWND
    } else when T == SurfaceDescriptorFromXlibWindow {
        l.s_type = .SurfaceDescriptorFromXlibWindow
    } else when T == SurfaceDescriptorFromCanvasHTMLSelector {
        l.s_type = .SurfaceDescriptorFromCanvasHTMLSelector
    } else when T == SurfaceDescriptorFromWaylandSurface {
        l.s_type = .SurfaceDescriptorFromWaylandSurface
    } else when T == SurfaceDescriptorFromXcbWindow {
        l.s_type = .SurfaceDescriptorFromXcbWindow
    } else when T == SurfaceDescriptorFromAndroidNativeWindow {
        l.s_type = .SurfaceDescriptorFromAndroidNativeWindow
    } else when T == ShaderModuleSPIRVDescriptor {
        l.s_type = .ShaderModuleSPIRVDescriptor
    } else when T == ShaderModuleWGSLDescriptor {
        l.s_type = .ShaderModuleWGSLDescriptor
    } else when T == PrimitiveDepthClipControl {
        l.s_type = .PrimitiveDepthClipControl
    } else when T == RenderPassDescriptorMaxDrawCount {
        l.s_type = .RenderPassDescriptorMaxDrawCount
    } else when WGPU_NATIVE {
        when T == DeviceExtras {
            l.s_type = .DeviceExtras
        } else when T == RequiredLimitsExtras {
            l.s_type = .RequiredLimitsExtras
        } else when T == SupportedLimitsExtras {
            l.s_type = .SupportedLimitsExtras
        } else when T == PipelineLayoutExtras {
            l.s_type = .PipelineLayoutExtras
        } else when T == InstanceExtras {
            l.s_type = .InstanceExtras
        } else when T == SwapChainDescriptorExtras {
            l.s_type = .SwapChainDescriptorExtras
        } else when T == ShaderModuleGLSLDescriptor {
            l.s_type = .ShaderModuleGLSLDescriptor
        } else do #panic("not implemented in link()")
    } else do #panic("not implemented in link()")
    return l
}

chain :: proc(links: ..^ChainedStruct) -> (c: ^ChainedStruct) {
    if len(links) == 0 do return
    c = links[0]
    selector := c
    for l in links[1:] {
        selector.next = l
        selector = l
    }
    return
}
chain_out :: proc(links: ..^ChainedStructOut) -> (c: ^ChainedStructOut) {
    if len(links) == 0 do return
    c = links[0]
    selector := c
    for l in links[1:] {
        selector.next = l
        selector = l
    }
    return
}

request_cb :: proc "contextless" ($CallbackType: typeid) -> CallbackType where
    intrinsics.type_is_proc(CallbackType) &&
    intrinsics.type_proc_parameter_count(CallbackType) == 4 &&
    intrinsics.type_proc_return_count(CallbackType) == 0 &&
    intrinsics.type_proc_parameter_type(CallbackType, 2) == cstring &&
    intrinsics.type_proc_parameter_type(CallbackType, 3) == rawptr
{
    Status :: intrinsics.type_proc_parameter_type(CallbackType, 0)
    Res :: intrinsics.type_proc_parameter_type(CallbackType, 1)
    return proc "c" (status: Status, res: Res, message: cstring, user_data: rawptr) {
        out := transmute(^Res)user_data
        if status == .Success {
            out^ = res
        } else {
            context = runtime.default_context()
            fmt.printf("Could not get %v: %s\n", typeid_of(Res), message)
        }
    }
}
