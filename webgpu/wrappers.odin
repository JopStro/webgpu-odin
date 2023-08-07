package webgpu

when ODIN_OS == .Linux {
    foreign import wgpu "bin/linux/libwgpu_native.a"
} else when ODIN_OS == .Darwin {
    when ODIN_ARCH == .arm64 {
        foreign import wgpu "bin/mac/arm/libwgpu_native.a"
    } else {
        foreign import wgpu "bin/mac/libwgpu_native.a"
    }
} else when ODIN_OS == .Windows {
    foreign import wgpu "bin/windows/libwgpu_native.lib"
}

import _c "core:c"
import "core:intrinsics"

@(private = "file", default_calling_convention = "c")
foreign wgpu {

    @(link_name = "wgpuAdapterEnumerateFeatures")
    _adapter_enumerate_features :: proc(adapter: Adapter, features: [^]FeatureName) -> _c.size_t ---

    @(link_name = "wgpuAdapterGetLimits")
    _adapter_get_limits :: proc(adapter: Adapter, limits: ^SupportedLimits) -> bool ---

    @(link_name = "wgpuAdapterGetProperties")
    _adapter_get_properties :: proc(adapter: Adapter, properties: ^AdapterProperties) ---

    @(link_name = "wgpuDeviceEnumerateFeatures")
    _device_enumerate_features :: proc(device: Device, features: [^]FeatureName) -> _c.size_t ---

    @(link_name = "wgpuDeviceGetLimits")
    _device_get_limits :: proc(device: Device, limits: ^SupportedLimits) -> bool ---

    @(link_name = "wgpuQueueSubmit")
    _queue_submit :: proc(queue: Queue, command_count: _c.size_t, commands: [^]CommandBuffer) ---

    @(link_name = "wgpuQueueWriteBuffer")
    _queue_write_buffer :: proc(queue: Queue, buffer: Buffer, buffer_offset: u64, data: rawptr, size: _c.size_t) ---

    //WGPU NATIVE
    when WGPU_NATIVE {
        @(link_name = "wgpuInstanceEnumerateAdapters")
        _instance_enumerate_adapters :: proc(instance: Instance, #by_ptr options: InstanceEnumerateAdapterOptions, adapters: [^]Adapter) -> _c.size_t ---

        @(link_name = "wgpuQueueSubmitForIndex")
        _queue_submit_for_index :: proc(queue: Queue, command_count: _c.size_t, commands: [^]CommandBuffer) -> u64 ---

        @(link_name = "wgpuSurfaceGetCapabilities")
        _surface_get_capabilities :: proc(surface: Surface, adapter: Adapter, capabilities: ^SurfaceCapabilities) ---
    }
}


adapter_enumerate_features :: proc(adapter: Adapter, allocator := context.allocator) -> (features: []FeatureName) {
    size := _adapter_enumerate_features(adapter, nil)
    mp := make([^]FeatureName, size, allocator)
    _adapter_enumerate_features(adapter, mp)
    return mp[:size]
}

adapter_get_limits :: proc(adapter: Adapter) -> (limits: SupportedLimits, ok: bool) #optional_ok {
    ok = _adapter_get_limits(adapter, &limits)
    return
}

adapter_get_properties :: proc(adapter: Adapter) -> (properties: AdapterProperties) {
    _adapter_get_properties(adapter, &properties)
    return
}

device_enumerate_features :: proc(device: Device, allocator := context.allocator) -> (features: []FeatureName) {
    size := _device_enumerate_features(device, nil)
    mp := make([^]FeatureName, size, allocator)
    _device_enumerate_features(device, mp)
    return mp[:size]
}

device_get_limits :: proc(device: Device) -> (limits: SupportedLimits, ok: bool) #optional_ok {
    ok = _device_get_limits(device, &limits)
    return
}

queue_submit :: proc(queue: Queue, commands: []CommandBuffer) {
    _queue_submit(queue, len(commands), raw_data(commands))
}

queue_write_buffer :: proc(queue: Queue, buffer: Buffer, buffer_offset: u64, data: []$T) {
    _queue_write_buffer(queue, buffer, buffer_offset, raw_data(data), size_of(T) * len(data))
}

//WGPU NATIVE
when WGPU_NATIVE {
    instance_enumerate_adapters :: proc(instance: Instance, options: InstanceEnumerateAdapterOptions, allocator := context.allocator) -> (adapters: []Adapter) {
        size := _instance_enumerate_adapters(instance, options, nil)
        mp := make([^]Adapter, size)
        _instance_enumerate_adapters(instance, options, mp)
        return mp[:size]
    }

    queue_submit_for_index :: proc(queue: Queue, commands: []CommandBuffer) -> u64 {
        return _queue_submit_for_index(queue, len(commands), raw_data(commands))
    }

    surface_get_capabilities :: proc(surface: Surface, adapter: Adapter) -> (capabilities: SurfaceCapabilities) {
        _surface_get_capabilities(surface, adapter, &capabilities)
        return
    }
}
