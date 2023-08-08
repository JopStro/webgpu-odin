package webgpu

WGPU_NATIVE :: true

when ODIN_OS == .Linux {
    foreign import wgpu "bin/linux/libwgpu_native.a"
} else when ODIN_OS == .Darwin {
    when ODIN_ARCH == .arm64 {
        foreign import wgpu "bin/mac/arm/libwgpu_native.a"
    } else {
        foreign import wgpu "bin/mac/libwgpu_native.a"
    }
} else when ODIN_OS == .Windows {
    foreign import wgpu {
        "bin/windows/libwgpu_native.lib",
        "system:d3dcompiler.lib",
        "system:bcrypt.lib",
        "system:lntdll.lib",
        "system:ws2_32.lib",
        "system:advapi32.lib",
        "system:userenv.lib",
        "system:user32.lib",
    }
} else {
    #panic("platform unsupported")
}

import _c "core:c"

ARRAY_LAYER_COUNT_UNDEFINED: u32 : 0xffffffff
COPY_STRIDE_UNDEFINED: u32 : 0xffffffff
LIMIT_U32_UNDEFINED: u32 : 0xffffffff
LIMIT_U64_UNDEFINED: u64 : 0xffffffffffffffff
MIP_LEVEL_COUNT_UNDEFINED: u32 : 0xffffffff
WHOLE_MAP_SIZE: u64 : 0xffffffffffffffff
WHOLE_SIZE: u64 : 0xffffffffffffffff

Adapter :: distinct rawptr
BindGroup :: distinct rawptr
BindGroupLayout :: distinct rawptr
Buffer :: distinct rawptr
CommandBuffer :: distinct rawptr
CommandEncoder :: distinct rawptr
ComputePassEncoder :: distinct rawptr
ComputePipeline :: distinct rawptr
Device :: distinct rawptr
Instance :: distinct rawptr
PipelineLayout :: distinct rawptr
QuerySet :: distinct rawptr
Queue :: distinct rawptr
RenderBundle :: distinct rawptr
RenderBundleEncoder :: distinct rawptr
RenderPassEncoder :: distinct rawptr
RenderPipeline :: distinct rawptr
Sampler :: distinct rawptr
ShaderModule :: distinct rawptr
Surface :: distinct rawptr
SwapChain :: distinct rawptr
Texture :: distinct rawptr
TextureView :: distinct rawptr
BufferMapCallback :: #type proc "c" (status: BufferMapAsyncStatus, userdata: rawptr)
CompilationInfoCallback :: #type proc "c" (status: CompilationInfoRequestStatus, compilation_info: ^CompilationInfo, userdata: rawptr)
CreateComputePipelineAsyncCallback :: #type proc "c" (status: CreatePipelineAsyncStatus, pipeline: ComputePipeline, message: cstring, userdata: rawptr)
CreateRenderPipelineAsyncCallback :: #type proc "c" (status: CreatePipelineAsyncStatus, pipeline: RenderPipeline, message: cstring, userdata: rawptr)
DeviceLostCallback :: #type proc "c" (reason: DeviceLostReason, message: cstring, userdata: rawptr)
ErrorCallback :: #type proc "c" (type: ErrorType, message: cstring, userdata: rawptr)
QueueWorkDoneCallback :: #type proc "c" (status: QueueWorkDoneStatus, userdata: rawptr)
RequestAdapterCallback :: #type proc "c" (status: RequestAdapterStatus, adapter: Adapter, message: cstring, userdata: rawptr)
RequestDeviceCallback :: #type proc "c" (status: RequestDeviceStatus, device: Device, message: cstring, userdata: rawptr)

when WGPU_NATIVE {
    SubmissionIndex :: u64
    LogCallback :: #type proc "c" (level: LogLevel, message: cstring, userdata: rawptr)
}

AdapterType :: enum i32 {
    DiscreteGPU   = 0,
    IntegratedGPU = 1,
    CPU           = 2,
    Unknown       = 3,
    Force32       = 2147483647,
}

AddressMode :: enum i32 {
    Repeat       = 0,
    MirrorRepeat = 1,
    ClampToEdge  = 2,
    Force32      = 2147483647,
}

BackendType :: enum i32 {
    Undefined = 0,
    Null      = 1,
    WebGPU    = 2,
    D3D11     = 3,
    D3D12     = 4,
    Metal     = 5,
    Vulkan    = 6,
    OpenGL    = 7,
    OpenGLES  = 8,
    Force32   = 2147483647,
}

BlendFactor :: enum i32 {
    Zero              = 0,
    One               = 1,
    Src               = 2,
    OneMinusSrc       = 3,
    SrcAlpha          = 4,
    OneMinusSrcAlpha  = 5,
    Dst               = 6,
    OneMinusDst       = 7,
    DstAlpha          = 8,
    OneMinusDstAlpha  = 9,
    SrcAlphaSaturated = 10,
    Constant          = 11,
    OneMinusConstant  = 12,
    Force32           = 2147483647,
}

BlendOperation :: enum i32 {
    Add             = 0,
    Subtract        = 1,
    ReverseSubtract = 2,
    Min             = 3,
    Max             = 4,
    Force32         = 2147483647,
}

BufferBindingType :: enum i32 {
    Undefined       = 0,
    Uniform         = 1,
    Storage         = 2,
    ReadOnlyStorage = 3,
    Force32         = 2147483647,
}

BufferMapAsyncStatus :: enum i32 {
    Success                 = 0,
    ValidationError         = 1,
    Unknown                 = 2,
    DeviceLost              = 3,
    DestroyedBeforeCallback = 4,
    UnmappedBeforeCallback  = 5,
    MappingAlreadyPending   = 6,
    OffsetOutOfRange        = 7,
    SizeOutOfRange          = 8,
    Force32                 = 2147483647,
}

BufferMapState :: enum i32 {
    Unmapped = 0,
    Pending  = 1,
    Mapped   = 2,
    Force32  = 2147483647,
}

CompareFunction :: enum i32 {
    Undefined    = 0,
    Never        = 1,
    Less         = 2,
    LessEqual    = 3,
    Greater      = 4,
    GreaterEqual = 5,
    Equal        = 6,
    NotEqual     = 7,
    Always       = 8,
    Force32      = 2147483647,
}

CompilationInfoRequestStatus :: enum i32 {
    Success    = 0,
    Error      = 1,
    DeviceLost = 2,
    Unknown    = 3,
    Force32    = 2147483647,
}

CompilationMessageType :: enum i32 {
    Error   = 0,
    Warning = 1,
    Info    = 2,
    Force32 = 2147483647,
}

ComputePassTimestampLocation :: enum i32 {
    Beginning = 0,
    End       = 1,
    Force32   = 2147483647,
}

CreatePipelineAsyncStatus :: enum i32 {
    Success         = 0,
    ValidationError = 1,
    InternalError   = 2,
    DeviceLost      = 3,
    DeviceDestroyed = 4,
    Unknown         = 5,
    Force32         = 2147483647,
}

CullMode :: enum i32 {
    None    = 0,
    Front   = 1,
    Back    = 2,
    Force32 = 2147483647,
}

DeviceLostReason :: enum i32 {
    Undefined = 0,
    Destroyed = 1,
    Force32   = 2147483647,
}

ErrorFilter :: enum i32 {
    Validation  = 0,
    OutOfMemory = 1,
    Internal    = 2,
    Force32     = 2147483647,
}

ErrorType :: enum i32 {
    NoError     = 0,
    Validation  = 1,
    OutOfMemory = 2,
    Internal    = 3,
    Unknown     = 4,
    DeviceLost  = 5,
    Force32     = 2147483647,
}

FeatureName :: enum i32 {
    Undefined               = 0,
    DepthClipControl        = 1,
    Depth32FloatStencil8    = 2,
    TimestampQuery          = 3,
    PipelineStatisticsQuery = 4,
    TextureCompressionBC    = 5,
    TextureCompressionETC2  = 6,
    TextureCompressionASTC  = 7,
    IndirectFirstInstance   = 8,
    ShaderF16               = 9,
    RG11B10UfloatRenderable = 10,
    BGRA8UnormStorage       = 11,
    Float32Filterable       = 12,
    Force32                 = 2147483647,
}

FilterMode :: enum i32 {
    Nearest = 0,
    Linear  = 1,
    Force32 = 2147483647,
}

FrontFace :: enum i32 {
    CCW     = 0,
    CW      = 1,
    Force32 = 2147483647,
}

IndexFormat :: enum i32 {
    Undefined = 0,
    Uint16    = 1,
    Uint32    = 2,
    Force32   = 2147483647,
}

LoadOp :: enum i32 {
    Undefined = 0,
    Clear     = 1,
    Load      = 2,
    Force32   = 2147483647,
}

MipmapFilterMode :: enum i32 {
    Nearest = 0,
    Linear  = 1,
    Force32 = 2147483647,
}

PipelineStatisticName :: enum i32 {
    VertexShaderInvocations   = 0,
    ClipperInvocations        = 1,
    ClipperPrimitivesOut      = 2,
    FragmentShaderInvocations = 3,
    ComputeShaderInvocations  = 4,
    Force32                   = 2147483647,
}

PowerPreference :: enum i32 {
    Undefined       = 0,
    LowPower        = 1,
    HighPerformance = 2,
    Force32         = 2147483647,
}

PresentMode :: enum i32 {
    Immediate = 0,
    Mailbox   = 1,
    Fifo      = 2,
    Force32   = 2147483647,
}

PrimitiveTopology :: enum i32 {
    PointList     = 0,
    LineList      = 1,
    LineStrip     = 2,
    TriangleList  = 3,
    TriangleStrip = 4,
    Force32       = 2147483647,
}

QueryType :: enum i32 {
    Occlusion          = 0,
    PipelineStatistics = 1,
    Timestamp          = 2,
    Force32            = 2147483647,
}

QueueWorkDoneStatus :: enum i32 {
    Success    = 0,
    Error      = 1,
    Unknown    = 2,
    DeviceLost = 3,
    Force32    = 2147483647,
}

RenderPassTimestampLocation :: enum i32 {
    Beginning = 0,
    End       = 1,
    Force32   = 2147483647,
}

RequestAdapterStatus :: enum i32 {
    Success     = 0,
    Unavailable = 1,
    Error       = 2,
    Unknown     = 3,
    Force32     = 2147483647,
}

RequestDeviceStatus :: enum i32 {
    Success = 0,
    Error   = 1,
    Unknown = 2,
    Force32 = 2147483647,
}
when WGPU_NATIVE {
    SType :: enum i32 {
        Invalid                                  = 0,
        SurfaceDescriptorFromMetalLayer          = 1,
        SurfaceDescriptorFromWindowsHWND         = 2,
        SurfaceDescriptorFromXlibWindow          = 3,
        SurfaceDescriptorFromCanvasHTMLSelector  = 4,
        ShaderModuleSPIRVDescriptor              = 5,
        ShaderModuleWGSLDescriptor               = 6,
        PrimitiveDepthClipControl                = 7,
        SurfaceDescriptorFromWaylandSurface      = 8,
        SurfaceDescriptorFromAndroidNativeWindow = 9,
        SurfaceDescriptorFromXcbWindow           = 10,
        RenderPassDescriptorMaxDrawCount         = 15,
        // wgpu-native Extensions
        DeviceExtras                             = 1610612737,
        AdapterExtras                            = 1610612738,
        RequiredLimitsExtras                     = 1610612739,
        PipelineLayoutExtras                     = 1610612740,
        ShaderModuleGLSLDescriptor               = 1610612741,
        SupportedLimitsExtras                    = 1610612739,
        InstanceExtras                           = 1610612742,
        SwapChainDescriptorExtras                = 1610612743,
        Force32                                  = 2147483647,
    }
} else {
    SType :: enum i32 {
        Invalid                                  = 0,
        SurfaceDescriptorFromMetalLayer          = 1,
        SurfaceDescriptorFromWindowsHWND         = 2,
        SurfaceDescriptorFromXlibWindow          = 3,
        SurfaceDescriptorFromCanvasHTMLSelector  = 4,
        ShaderModuleSPIRVDescriptor              = 5,
        ShaderModuleWGSLDescriptor               = 6,
        PrimitiveDepthClipControl                = 7,
        SurfaceDescriptorFromWaylandSurface      = 8,
        SurfaceDescriptorFromAndroidNativeWindow = 9,
        SurfaceDescriptorFromXcbWindow           = 10,
        RenderPassDescriptorMaxDrawCount         = 15,
        Force32                                  = 2147483647,
    }
}

SamplerBindingType :: enum i32 {
    Undefined    = 0,
    Filtering    = 1,
    NonFiltering = 2,
    Comparison   = 3,
    Force32      = 2147483647,
}

StencilOperation :: enum i32 {
    Keep           = 0,
    Zero           = 1,
    Replace        = 2,
    Invert         = 3,
    IncrementClamp = 4,
    DecrementClamp = 5,
    IncrementWrap  = 6,
    DecrementWrap  = 7,
    Force32        = 2147483647,
}

StorageTextureAccess :: enum i32 {
    Undefined = 0,
    WriteOnly = 1,
    Force32   = 2147483647,
}

StoreOp :: enum i32 {
    Undefined = 0,
    Store     = 1,
    Discard   = 2,
    Force32   = 2147483647,
}

TextureAspect :: enum i32 {
    All         = 0,
    StencilOnly = 1,
    DepthOnly   = 2,
    Force32     = 2147483647,
}

TextureDimension :: enum i32 {
    OneD    = 0,
    TwoD    = 1,
    ThreeD  = 2,
    Force32 = 2147483647,
}

TextureFormat :: enum i32 {
    Undefined            = 0,
    R8Unorm              = 1,
    R8Snorm              = 2,
    R8Uint               = 3,
    R8Sint               = 4,
    R16Uint              = 5,
    R16Sint              = 6,
    R16Float             = 7,
    RG8Unorm             = 8,
    RG8Snorm             = 9,
    RG8Uint              = 10,
    RG8Sint              = 11,
    R32Float             = 12,
    R32Uint              = 13,
    R32Sint              = 14,
    RG16Uint             = 15,
    RG16Sint             = 16,
    RG16Float            = 17,
    RGBA8Unorm           = 18,
    RGBA8UnormSrgb       = 19,
    RGBA8Snorm           = 20,
    RGBA8Uint            = 21,
    RGBA8Sint            = 22,
    BGRA8Unorm           = 23,
    BGRA8UnormSrgb       = 24,
    RGB10A2Unorm         = 25,
    RG11B10Ufloat        = 26,
    RGB9E5Ufloat         = 27,
    RG32Float            = 28,
    RG32Uint             = 29,
    RG32Sint             = 30,
    RGBA16Uint           = 31,
    RGBA16Sint           = 32,
    RGBA16Float          = 33,
    RGBA32Float          = 34,
    RGBA32Uint           = 35,
    RGBA32Sint           = 36,
    Stencil8             = 37,
    Depth16Unorm         = 38,
    Depth24Plus          = 39,
    Depth24PlusStencil8  = 40,
    Depth32Float         = 41,
    Depth32FloatStencil8 = 42,
    BC1RGBAUnorm         = 43,
    BC1RGBAUnormSrgb     = 44,
    BC2RGBAUnorm         = 45,
    BC2RGBAUnormSrgb     = 46,
    BC3RGBAUnorm         = 47,
    BC3RGBAUnormSrgb     = 48,
    BC4RUnorm            = 49,
    BC4RSnorm            = 50,
    BC5RGUnorm           = 51,
    BC5RGSnorm           = 52,
    BC6HRGBUfloat        = 53,
    BC6HRGBFloat         = 54,
    BC7RGBAUnorm         = 55,
    BC7RGBAUnormSrgb     = 56,
    ETC2RGB8Unorm        = 57,
    ETC2RGB8UnormSrgb    = 58,
    ETC2RGB8A1Unorm      = 59,
    ETC2RGB8A1UnormSrgb  = 60,
    ETC2RGBA8Unorm       = 61,
    ETC2RGBA8UnormSrgb   = 62,
    EACR11Unorm          = 63,
    EACR11Snorm          = 64,
    EACRG11Unorm         = 65,
    EACRG11Snorm         = 66,
    ASTC4x4Unorm         = 67,
    ASTC4x4UnormSrgb     = 68,
    ASTC5x4Unorm         = 69,
    ASTC5x4UnormSrgb     = 70,
    ASTC5x5Unorm         = 71,
    ASTC5x5UnormSrgb     = 72,
    ASTC6x5Unorm         = 73,
    ASTC6x5UnormSrgb     = 74,
    ASTC6x6Unorm         = 75,
    ASTC6x6UnormSrgb     = 76,
    ASTC8x5Unorm         = 77,
    ASTC8x5UnormSrgb     = 78,
    ASTC8x6Unorm         = 79,
    ASTC8x6UnormSrgb     = 80,
    ASTC8x8Unorm         = 81,
    ASTC8x8UnormSrgb     = 82,
    ASTC10x5Unorm        = 83,
    ASTC10x5UnormSrgb    = 84,
    ASTC10x6Unorm        = 85,
    ASTC10x6UnormSrgb    = 86,
    ASTC10x8Unorm        = 87,
    ASTC10x8UnormSrgb    = 88,
    ASTC10x10Unorm       = 89,
    ASTC10x10UnormSrgb   = 90,
    ASTC12x10Unorm       = 91,
    ASTC12x10UnormSrgb   = 92,
    ASTC12x12Unorm       = 93,
    ASTC12x12UnormSrgb   = 94,
    Force32              = 2147483647,
}

TextureSampleType :: enum i32 {
    Undefined         = 0,
    Float             = 1,
    UnfilterableFloat = 2,
    Depth             = 3,
    Sint              = 4,
    Uint              = 5,
    Force32           = 2147483647,
}

TextureViewDimension :: enum i32 {
    Undefined = 0,
    OneD      = 1,
    TwoD      = 2,
    TwoDArray = 3,
    Cube      = 4,
    CubeArray = 5,
    ThreeD    = 6,
    Force32   = 2147483647,
}

VertexFormat :: enum i32 {
    Undefined = 0,
    Uint8x2   = 1,
    Uint8x4   = 2,
    Sint8x2   = 3,
    Sint8x4   = 4,
    Unorm8x2  = 5,
    Unorm8x4  = 6,
    Snorm8x2  = 7,
    Snorm8x4  = 8,
    Uint16x2  = 9,
    Uint16x4  = 10,
    Sint16x2  = 11,
    Sint16x4  = 12,
    Unorm16x2 = 13,
    Unorm16x4 = 14,
    Snorm16x2 = 15,
    Snorm16x4 = 16,
    Float16x2 = 17,
    Float16x4 = 18,
    Float32   = 19,
    Float32x2 = 20,
    Float32x3 = 21,
    Float32x4 = 22,
    Uint32    = 23,
    Uint32x2  = 24,
    Uint32x3  = 25,
    Uint32x4  = 26,
    Sint32    = 27,
    Sint32x2  = 28,
    Sint32x3  = 29,
    Sint32x4  = 30,
    Force32   = 2147483647,
}

VertexStepMode :: enum i32 {
    Vertex              = 0,
    Instance            = 1,
    VertexBufferNotUsed = 2,
    Force32             = 2147483647,
}

BufferUsageFlags :: enum i32 {
    None         = 0,
    MapRead      = 1,
    MapWrite     = 2,
    CopySrc      = 4,
    CopyDst      = 8,
    Index        = 16,
    Vertex       = 32,
    Uniform      = 64,
    Storage      = 128,
    Indirect     = 256,
    QueryResolve = 512,
    Force32      = 2147483647,
}

ColorWriteMaskFlags :: enum i32 {
    None    = 0,
    Red     = 1,
    Green   = 2,
    Blue    = 4,
    Alpha   = 8,
    All     = 15,
    Force32 = 2147483647,
}

MapModeFlags :: enum i32 {
    None    = 0,
    Read    = 1,
    Write   = 2,
    Force32 = 2147483647,
}

ShaderStageFlags :: enum i32 {
    None     = 0,
    Vertex   = 1,
    Fragment = 2,
    Compute  = 4,
    Force32  = 2147483647,
}

TextureUsageFlags :: enum i32 {
    None             = 0,
    CopySrc          = 1,
    CopyDst          = 2,
    TextureBinding   = 4,
    StorageBinding   = 8,
    RenderAttachment = 16,
    Force32          = 2147483647,
}

when WGPU_NATIVE {
    NativeFeature :: enum i32 {
        PushConstants                        = 1610612737,
        TextureAdapterSpecificFormatFeatures = 1610612738,
        MultiDrawIndirect                    = 1610612739,
        MultiDrawIndirectCount               = 1610612740,
        VertexWritableStorage                = 1610612741,
        Force32                              = 2147483647,
    }

    LogLevel :: enum i32 {
        Off     = 0,
        Error   = 1,
        Warn    = 2,
        Info    = 3,
        Debug   = 4,
        Trace   = 5,
        Force32 = 2147483647,
    }

    InstanceBackendFlags :: enum i32 {
        Vulkan        = 2,
        GL            = 32,
        Metal         = 4,
        DX12          = 8,
        DX11          = 16,
        BrowserWebGPU = 64,
        Primary       = Vulkan | Metal | DX12 | BrowserWebGPU,
        Secondary     = GL | DX11,
        None          = 0,
        Force32       = 2147483647,
    }

    Dx12Compiler :: enum i32 {
        Undefined = 0,
        Fxc       = 1,
        Dxc       = 2,
        Force32   = 2147483647,
    }

    CompositeAlphaMode :: enum i32 {
        Auto           = 0,
        Opaque         = 1,
        PreMultiplied  = 2,
        PostMultiplied = 3,
        Inherit        = 4,
        Force32        = 2147483647,
    }
}

AdapterProperties :: struct {
    next_in_chain:      ^ChainedStructOut,
    vendor_id:          u32,
    vendor_name:        cstring,
    architecture:       cstring,
    device_id:          u32,
    name:               cstring,
    driver_description: cstring,
    adapter_type:       AdapterType,
    backend_type:       BackendType,
}

BindGroupEntry :: struct {
    next_in_chain: ^ChainedStruct,
    binding:       u32,
    buffer:        Buffer,
    offset:        u64,
    size:          u64,
    sampler:       Sampler,
    texture_view:  TextureView,
}

BlendComponent :: struct {
    operation:  BlendOperation,
    src_factor: BlendFactor,
    dst_factor: BlendFactor,
}

BufferBindingLayout :: struct {
    next_in_chain:      ^ChainedStruct,
    type:               BufferBindingType,
    has_dynamic_offset: bool,
    min_binding_size:   u64,
}

BufferDescriptor :: struct {
    next_in_chain:      ^ChainedStruct,
    label:              cstring,
    usage:              BufferUsageFlags,
    size:               u64,
    mapped_at_creation: bool,
}

Color :: struct {
    r: _c.double,
    g: _c.double,
    b: _c.double,
    a: _c.double,
}

CommandBufferDescriptor :: struct {
    next_in_chain: ^ChainedStruct,
    label:         cstring,
}

CommandEncoderDescriptor :: struct {
    next_in_chain: ^ChainedStruct,
    label:         cstring,
}

CompilationMessage :: struct {
    next_in_chain:  ^ChainedStruct,
    message:        cstring,
    type:           CompilationMessageType,
    line_num:       u64,
    line_pos:       u64,
    offset:         u64,
    length:         u64,
    utf16_line_pos: u64,
    utf16_offset:   u64,
    utf16_length:   u64,
}

ComputePassTimestampWrite :: struct {
    query_set:   QuerySet,
    query_index: u32,
    location:    ComputePassTimestampLocation,
}

ConstantEntry :: struct {
    next_in_chain: ^ChainedStruct,
    key:           cstring,
    value:         _c.double,
}

Extent3D :: struct {
    width:                 u32,
    height:                u32,
    depth_or_array_layers: u32,
}

InstanceDescriptor :: struct {
    next_in_chain: ^ChainedStruct,
}

Limits :: struct {
    max_texture_dimension_1d:                        u32,
    max_texture_dimension_2d:                        u32,
    max_texture_dimension_3d:                        u32,
    max_texture_array_layers:                        u32,
    max_bind_groups:                                 u32,
    max_bindings_per_bind_group:                     u32,
    max_dynamic_uniform_buffers_per_pipeline_layout: u32,
    max_dynamic_storage_buffers_per_pipeline_layout: u32,
    max_sampled_textures_per_shader_stage:           u32,
    max_samplers_per_shader_stage:                   u32,
    max_storage_buffers_per_shader_stage:            u32,
    max_storage_textures_per_shader_stage:           u32,
    max_uniform_buffers_per_shader_stage:            u32,
    max_uniform_buffer_binding_size:                 u64,
    max_storage_buffer_binding_size:                 u64,
    min_uniform_buffer_offset_alignment:             u32,
    min_storage_buffer_offset_alignment:             u32,
    max_vertex_buffers:                              u32,
    max_buffer_size:                                 u64,
    max_vertex_attributes:                           u32,
    max_vertex_buffer_array_stride:                  u32,
    max_inter_stage_shader_components:               u32,
    max_inter_stage_shader_variables:                u32,
    max_color_attachments:                           u32,
    max_color_attachment_bytes_per_sample:           u32,
    max_compute_workgroup_storage_size:              u32,
    max_compute_invocations_per_workgroup:           u32,
    max_compute_workgroup_size_x:                    u32,
    max_compute_workgroup_size_y:                    u32,
    max_compute_workgroup_size_z:                    u32,
    max_compute_workgroups_per_dimension:            u32,
}

MultisampleState :: struct {
    next_in_chain:             ^ChainedStruct,
    count:                     u32,
    mask:                      u32,
    alpha_to_coverage_enabled: bool,
}

Origin3D :: struct {
    x: u32,
    y: u32,
    z: u32,
}

PipelineLayoutDescriptor :: struct {
    next_in_chain:           ^ChainedStruct,
    label:                   cstring,
    bind_group_layout_count: _c.size_t,
    bind_group_layouts:      [^]BindGroupLayout,
}

PrimitiveDepthClipControl :: struct {
    using chain:     ChainedStruct,
    unclipped_depth: bool,
}

PrimitiveState :: struct {
    next_in_chain:      ^ChainedStruct,
    topology:           PrimitiveTopology,
    strip_index_format: IndexFormat,
    front_face:         FrontFace,
    cull_mode:          CullMode,
}

QuerySetDescriptor :: struct {
    next_in_chain:             ^ChainedStruct,
    label:                     cstring,
    type:                      QueryType,
    count:                     u32,
    pipeline_statistics:       [^]PipelineStatisticName,
    pipeline_statistics_count: _c.size_t,
}

QueueDescriptor :: struct {
    next_in_chain: ^ChainedStruct,
    label:         cstring,
}

RenderBundleDescriptor :: struct {
    next_in_chain: ^ChainedStruct,
    label:         cstring,
}

RenderBundleEncoderDescriptor :: struct {
    next_in_chain:        ^ChainedStruct,
    label:                cstring,
    color_formats_count:  _c.size_t,
    color_formats:        [^]TextureFormat,
    depth_stencil_format: TextureFormat,
    sample_count:         u32,
    depth_read_only:      bool,
    stencil_read_only:    bool,
}

RenderPassDepthStencilAttachment :: struct {
    view:                TextureView,
    depth_load_op:       LoadOp,
    depth_store_op:      StoreOp,
    depth_clear_value:   _c.float,
    depth_read_only:     bool,
    stencil_load_op:     LoadOp,
    stencil_store_op:    StoreOp,
    stencil_clear_value: u32,
    stencil_read_only:   bool,
}

RenderPassDescriptorMaxDrawCount :: struct {
    using chain:    ChainedStruct,
    max_draw_count: u64,
}

RenderPassTimestampWrite :: struct {
    query_set:   QuerySet,
    query_index: u32,
    location:    RenderPassTimestampLocation,
}

RequestAdapterOptions :: struct {
    next_in_chain:          ^ChainedStruct,
    compatible_surface:     Surface,
    power_preference:       PowerPreference,
    backend_type:           BackendType,
    force_fallback_adapter: bool,
}

SamplerBindingLayout :: struct {
    next_in_chain: ^ChainedStruct,
    type:          SamplerBindingType,
}

SamplerDescriptor :: struct {
    next_in_chain:  ^ChainedStruct,
    label:          cstring,
    address_mode_u: AddressMode,
    address_mode_v: AddressMode,
    address_mode_w: AddressMode,
    mag_filter:     FilterMode,
    min_filter:     FilterMode,
    mipmap_filter:  MipmapFilterMode,
    lod_min_clamp:  _c.float,
    lod_max_clamp:  _c.float,
    compare:        CompareFunction,
    max_anisotropy: u16,
}

ShaderModuleCompilationHint :: struct {
    next_in_chain: ^ChainedStruct,
    entry_point:   cstring,
    layout:        PipelineLayout,
}

ShaderModuleSPIRVDescriptor :: struct {
    using chain: ChainedStruct,
    code_size:   u32,
    code:        [^]u32,
}

ShaderModuleWGSLDescriptor :: struct {
    using chain: ChainedStruct,
    code:        cstring,
}

StencilFaceState :: struct {
    compare:       CompareFunction,
    fail_op:       StencilOperation,
    depth_fail_op: StencilOperation,
    pass_op:       StencilOperation,
}

StorageTextureBindingLayout :: struct {
    next_in_chain:  ^ChainedStruct,
    access:         StorageTextureAccess,
    format:         TextureFormat,
    view_dimension: TextureViewDimension,
}

SurfaceDescriptor :: struct {
    next_in_chain: ^ChainedStruct,
    label:         cstring,
}

SurfaceDescriptorFromAndroidNativeWindow :: struct {
    using chain: ChainedStruct,
    window:      rawptr,
}

SurfaceDescriptorFromCanvasHTMLSelector :: struct {
    using chain: ChainedStruct,
    selector:    cstring,
}

SurfaceDescriptorFromMetalLayer :: struct {
    using chain: ChainedStruct,
    layer:       rawptr,
}

SurfaceDescriptorFromWaylandSurface :: struct {
    using chain: ChainedStruct,
    display:     rawptr,
    surface:     rawptr,
}

SurfaceDescriptorFromWindowsHWND :: struct {
    using chain: ChainedStruct,
    hinstance:   rawptr,
    hwnd:        rawptr,
}

SurfaceDescriptorFromXcbWindow :: struct {
    using chain: ChainedStruct,
    connection:  rawptr,
    window:      u32,
}

SurfaceDescriptorFromXlibWindow :: struct {
    using chain: ChainedStruct,
    display:     rawptr,
    window:      u32,
}

SwapChainDescriptor :: struct {
    next_in_chain: ^ChainedStruct,
    label:         cstring,
    usage:         TextureUsageFlags,
    format:        TextureFormat,
    width:         u32,
    height:        u32,
    present_mode:  PresentMode,
}

TextureBindingLayout :: struct {
    next_in_chain:  ^ChainedStruct,
    sample_type:    TextureSampleType,
    view_dimension: TextureViewDimension,
    multisampled:   bool,
}

TextureDataLayout :: struct {
    next_in_chain:  ^ChainedStruct,
    offset:         u64,
    bytes_per_row:  u32,
    rows_per_image: u32,
}

TextureViewDescriptor :: struct {
    next_in_chain:     ^ChainedStruct,
    label:             cstring,
    format:            TextureFormat,
    dimension:         TextureViewDimension,
    base_mip_level:    u32,
    mip_level_count:   u32,
    base_array_layer:  u32,
    array_layer_count: u32,
    aspect:            TextureAspect,
}

VertexAttribute :: struct {
    format:          VertexFormat,
    offset:          u64,
    shader_location: u32,
}

BindGroupDescriptor :: struct {
    next_in_chain: ^ChainedStruct,
    label:         cstring,
    layout:        BindGroupLayout,
    entry_count:   _c.size_t,
    entries:       [^]BindGroupEntry,
}

BindGroupLayoutEntry :: struct {
    next_in_chain:   ^ChainedStruct,
    binding:         u32,
    visibility:      ShaderStageFlags,
    buffer:          BufferBindingLayout,
    sampler:         SamplerBindingLayout,
    texture:         TextureBindingLayout,
    storage_texture: StorageTextureBindingLayout,
}

BlendState :: struct {
    color: BlendComponent,
    alpha: BlendComponent,
}

CompilationInfo :: struct {
    next_in_chain: ^ChainedStruct,
    message_count: _c.size_t,
    messages:      [^]CompilationMessage,
}

ComputePassDescriptor :: struct {
    next_in_chain:         ^ChainedStruct,
    label:                 cstring,
    timestamp_write_count: _c.size_t,
    timestamp_writes:      [^]ComputePassTimestampWrite,
}

DepthStencilState :: struct {
    next_in_chain:          ^ChainedStruct,
    format:                 TextureFormat,
    depth_write_enabled:    bool,
    depth_compare:          CompareFunction,
    stencil_front:          StencilFaceState,
    stencil_back:           StencilFaceState,
    stencil_read_mask:      u32,
    stencil_write_mask:     u32,
    depth_bias:             i32,
    depth_bias_slope_scale: _c.float,
    depth_bias_clamp:       _c.float,
}

ImageCopyBuffer :: struct {
    next_in_chain: ^ChainedStruct,
    layout:        TextureDataLayout,
    buffer:        Buffer,
}

ImageCopyTexture :: struct {
    next_in_chain: ^ChainedStruct,
    texture:       Texture,
    mip_level:     u32,
    origin:        Origin3D,
    aspect:        TextureAspect,
}

ProgrammableStageDescriptor :: struct {
    next_in_chain:  ^ChainedStruct,
    module:         ShaderModule,
    entry_point:    cstring,
    constant_count: _c.size_t,
    constants:      [^]ConstantEntry,
}

RenderPassColorAttachment :: struct {
    view:           TextureView,
    resolve_target: TextureView,
    load_op:        LoadOp,
    store_op:       StoreOp,
    clear_value:    Color,
}

RequiredLimits :: struct {
    next_in_chain: ^ChainedStruct,
    limits:        Limits,
}

ShaderModuleDescriptor :: struct {
    next_in_chain: ^ChainedStruct,
    label:         cstring,
    hint_count:    _c.size_t,
    hints:         [^]ShaderModuleCompilationHint,
}

SupportedLimits :: struct {
    next_in_chain: ^ChainedStructOut,
    limits:        Limits,
}

TextureDescriptor :: struct {
    next_in_chain:     ^ChainedStruct,
    label:             cstring,
    usage:             TextureUsageFlags,
    dimension:         TextureDimension,
    size:              Extent3D,
    format:            TextureFormat,
    mip_level_count:   u32,
    sample_count:      u32,
    view_format_count: _c.size_t,
    view_formats:      [^]TextureFormat,
}

VertexBufferLayout :: struct {
    array_stride:    u64,
    step_mode:       VertexStepMode,
    attribute_count: _c.size_t,
    attributes:      [^]VertexAttribute,
}

BindGroupLayoutDescriptor :: struct {
    next_in_chain: ^ChainedStruct,
    label:         cstring,
    entry_count:   _c.size_t,
    entries:       [^]BindGroupLayoutEntry,
}

ColorTargetState :: struct {
    next_in_chain: ^ChainedStruct,
    format:        TextureFormat,
    blend:         ^BlendState,
    write_mask:    ColorWriteMaskFlags,
}

ComputePipelineDescriptor :: struct {
    next_in_chain: ^ChainedStruct,
    label:         cstring,
    layout:        PipelineLayout,
    compute:       ProgrammableStageDescriptor,
}

DeviceDescriptor :: struct {
    next_in_chain:           ^ChainedStruct,
    label:                   cstring,
    required_features_count: _c.size_t,
    required_features:       [^]FeatureName,
    required_limits:         ^RequiredLimits,
    default_queue:           QueueDescriptor,
    device_lost_callback:    DeviceLostCallback,
    device_lost_userdata:    rawptr,
}

RenderPassDescriptor :: struct {
    next_in_chain:            ^ChainedStruct,
    label:                    cstring,
    color_attachment_count:   _c.size_t,
    color_attachments:        [^]RenderPassColorAttachment,
    depth_stencil_attachment: ^RenderPassDepthStencilAttachment,
    occlusion_query_set:      QuerySet,
    timestamp_write_count:    _c.size_t,
    timestamp_writes:         [^]RenderPassTimestampWrite,
}

VertexState :: struct {
    next_in_chain:  ^ChainedStruct,
    module:         ShaderModule,
    entry_point:    cstring,
    constant_count: _c.size_t,
    constants:      [^]ConstantEntry,
    buffer_count:   _c.size_t,
    buffers:        [^]VertexBufferLayout,
}

FragmentState :: struct {
    next_in_chain:  ^ChainedStruct,
    module:         ShaderModule,
    entry_point:    cstring,
    constant_count: _c.size_t,
    constants:      [^]ConstantEntry,
    target_count:   _c.size_t,
    targets:        [^]ColorTargetState,
}

RenderPipelineDescriptor :: struct {
    next_in_chain: ^ChainedStruct,
    label:         cstring,
    layout:        PipelineLayout,
    vertex:        VertexState,
    primitive:     PrimitiveState,
    depth_stencil: ^DepthStencilState,
    multisample:   MultisampleState,
    fragment:      ^FragmentState,
}

ChainedStruct :: struct {
    next:   ^ChainedStruct,
    s_type: SType,
}

ChainedStructOut :: struct {
    next:   ^ChainedStructOut,
    s_type: SType,
}

when WGPU_NATIVE {
    InstanceExtras :: struct {
        using chain:          ChainedStruct,
        backends:             InstanceBackendFlags,
        dx12_shader_compiler: Dx12Compiler,
        dxil_path:            cstring,
        dxc_path:             cstring,
    }

    DeviceExtras :: struct {
        using chain: ChainedStruct,
        trace_path:  cstring,
    }

    RequiredLimitsExtras :: struct {
        using chain:            ChainedStruct,
        max_push_constant_size: u32,
    }

    SupportedLimitsExtras :: struct {
        using chain:            ChainedStructOut,
        max_push_constant_size: u32,
    }

    PushConstantRange :: struct {
        stages: ShaderStageFlags,
        start:  u32,
        end:    u32,
    }

    PipelineLayoutExtras :: struct {
        using chain:               ChainedStruct,
        push_constant_range_count: u32,
        push_constant_ranges:      [^]PushConstantRange,
    }

    WrappedSubmissionIndex :: struct {
        queue:            Queue,
        submission_index: u64,
    }

    ShaderDefine :: struct {
        name:  cstring,
        value: cstring,
    }

    ShaderModuleGLSLDescriptor :: struct {
        using chain:  ChainedStruct,
        stage:        ShaderStageFlags,
        code:         cstring,
        define_count: u32,
        defines:      [^]ShaderDefine,
    }

    StorageReport :: struct {
        num_occupied: _c.size_t,
        num_vacant:   _c.size_t,
        num_error:    _c.size_t,
        element_size: _c.size_t,
    }

    HubReport :: struct {
        adapters:           StorageReport,
        devices:            StorageReport,
        pipeline_layouts:   StorageReport,
        shader_modules:     StorageReport,
        bind_group_layouts: StorageReport,
        bind_groups:        StorageReport,
        command_buffers:    StorageReport,
        render_bundles:     StorageReport,
        render_pipelines:   StorageReport,
        compute_pipelines:  StorageReport,
        query_sets:         StorageReport,
        buffers:            StorageReport,
        textures:           StorageReport,
        texture_views:      StorageReport,
        samplers:           StorageReport,
    }

    GlobalReport :: struct {
        surfaces:     StorageReport,
        backend_type: BackendType,
        vulkan:       HubReport,
        metal:        HubReport,
        dx12:         HubReport,
        dx11:         HubReport,
        gl:           HubReport,
    }

    SurfaceCapabilities :: struct {
        format_count:       _c.size_t,
        formats:            [^]TextureFormat,
        present_mode_count: _c.size_t,
        present_modes:      [^]PresentMode,
        alpha_mode_count:   _c.size_t,
        alpha_modes:        [^]CompositeAlphaMode,
    }

    SwapChainDescriptorExtras :: struct {
        using chain:       ChainedStruct,
        alpha_mode:        CompositeAlphaMode,
        view_format_count: _c.size_t,
        view_formats:      [^]TextureFormat,
    }

    InstanceEnumerateAdapterOptions :: struct {
        next_in_chain: ^ChainedStruct,
        backends:      InstanceBackendFlags,
    }
}

@(default_calling_convention = "c")
foreign wgpu {

    @(link_name = "wgpuCreateInstance")
    create_instance :: proc(#by_ptr descriptor: InstanceDescriptor) -> Instance ---

    @(link_name = "wgpuGetProcAddress")
    get_proc_address :: proc(device: Device, proc_name: cstring) -> proc "c" () ---

    @(link_name = "wgpuAdapterHasFeature")
    adapter_has_feature :: proc(adapter: Adapter, feature: FeatureName) -> bool ---

    @(link_name = "wgpuAdapterRequestDevice")
    adapter_request_device :: proc(adapter: Adapter, #by_ptr descriptor: DeviceDescriptor, callback: RequestDeviceCallback, userdata: rawptr) ---

    @(link_name = "wgpuAdapterReference")
    adapter_reference :: proc(adapter: Adapter) ---

    @(link_name = "wgpuAdapterRelease")
    adapter_release :: proc(adapter: Adapter) ---

    @(link_name = "wgpuBindGroupSetLabel")
    bind_group_set_label :: proc(bind_group: BindGroup, label: cstring) ---

    @(link_name = "wgpuBindGroupReference")
    bind_group_reference :: proc(bind_group: BindGroup) ---

    @(link_name = "wgpuBindGroupRelease")
    bind_group_release :: proc(bind_group: BindGroup) ---

    @(link_name = "wgpuBindGroupLayoutSetLabel")
    bind_group_layout_set_label :: proc(bind_group_layout: BindGroupLayout, label: cstring) ---

    @(link_name = "wgpuBindGroupLayoutReference")
    bind_group_layout_reference :: proc(bind_group_layout: BindGroupLayout) ---

    @(link_name = "wgpuBindGroupLayoutRelease")
    bind_group_layout_release :: proc(bind_group_layout: BindGroupLayout) ---

    @(link_name = "wgpuBufferDestroy")
    buffer_destroy :: proc(buffer: Buffer) ---

    @(link_name = "wgpuBufferGetConstMappedRange")
    buffer_get_const_mapped_range :: proc(buffer: Buffer, offset: _c.size_t, size: _c.size_t) -> rawptr ---

    @(link_name = "wgpuBufferGetMapState")
    buffer_get_map_state :: proc(buffer: Buffer) -> BufferMapState ---

    @(link_name = "wgpuBufferGetMappedRange")
    buffer_get_mapped_range :: proc(buffer: Buffer, offset: _c.size_t, size: _c.size_t) -> rawptr ---

    @(link_name = "wgpuBufferGetSize")
    buffer_get_size :: proc(buffer: Buffer) -> u64 ---

    @(link_name = "wgpuBufferGetUsage")
    buffer_get_usage :: proc(buffer: Buffer) -> u32 ---

    @(link_name = "wgpuBufferMapAsync")
    buffer_map_async :: proc(buffer: Buffer, mode: u32, offset: _c.size_t, size: _c.size_t, callback: BufferMapCallback, userdata: rawptr) ---

    @(link_name = "wgpuBufferSetLabel")
    buffer_set_label :: proc(buffer: Buffer, label: cstring) ---

    @(link_name = "wgpuBufferUnmap")
    buffer_unmap :: proc(buffer: Buffer) ---

    @(link_name = "wgpuBufferReference")
    buffer_reference :: proc(buffer: Buffer) ---

    @(link_name = "wgpuBufferRelease")
    buffer_release :: proc(buffer: Buffer) ---

    @(link_name = "wgpuCommandBufferSetLabel")
    command_buffer_set_label :: proc(command_buffer: CommandBuffer, label: cstring) ---

    @(link_name = "wgpuCommandBufferReference")
    command_buffer_reference :: proc(command_buffer: CommandBuffer) ---

    @(link_name = "wgpuCommandBufferRelease")
    command_buffer_release :: proc(command_buffer: CommandBuffer) ---

    @(link_name = "wgpuCommandEncoderBeginComputePass")
    command_encoder_begin_compute_pass :: proc(command_encoder: CommandEncoder, #by_ptr descriptor: ComputePassDescriptor) -> ComputePassEncoder ---

    @(link_name = "wgpuCommandEncoderBeginRenderPass")
    command_encoder_begin_render_pass :: proc(command_encoder: CommandEncoder, #by_ptr descriptor: RenderPassDescriptor) -> RenderPassEncoder ---

    @(link_name = "wgpuCommandEncoderClearBuffer")
    command_encoder_clear_buffer :: proc(command_encoder: CommandEncoder, buffer: Buffer, offset: u64, size: u64) ---

    @(link_name = "wgpuCommandEncoderCopyBufferToBuffer")
    command_encoder_copy_buffer_to_buffer :: proc(command_encoder: CommandEncoder, source: Buffer, source_offset: u64, destination: Buffer, destination_offset: u64, size: u64) ---

    @(link_name = "wgpuCommandEncoderCopyBufferToTexture")
    command_encoder_copy_buffer_to_texture :: proc(command_encoder: CommandEncoder, #by_ptr source: ImageCopyBuffer, #by_ptr destination: ImageCopyTexture, #by_ptr copy_size: Extent3D) ---

    @(link_name = "wgpuCommandEncoderCopyTextureToBuffer")
    command_encoder_copy_texture_to_buffer :: proc(command_encoder: CommandEncoder, #by_ptr source: ImageCopyTexture, #by_ptr destination: ImageCopyBuffer, #by_ptr copy_size: Extent3D) ---

    @(link_name = "wgpuCommandEncoderCopyTextureToTexture")
    command_encoder_copy_texture_to_texture :: proc(command_encoder: CommandEncoder, #by_ptr source: ImageCopyTexture, #by_ptr destination: ImageCopyTexture, #by_ptr copy_size: Extent3D) ---

    @(link_name = "wgpuCommandEncoderFinish")
    command_encoder_finish :: proc(command_encoder: CommandEncoder, #by_ptr descriptor: CommandBufferDescriptor) -> CommandBuffer ---

    @(link_name = "wgpuCommandEncoderInsertDebugMarker")
    command_encoder_insert_debug_marker :: proc(command_encoder: CommandEncoder, marker_label: cstring) ---

    @(link_name = "wgpuCommandEncoderPopDebugGroup")
    command_encoder_pop_debug_group :: proc(command_encoder: CommandEncoder) ---

    @(link_name = "wgpuCommandEncoderPushDebugGroup")
    command_encoder_push_debug_group :: proc(command_encoder: CommandEncoder, group_label: cstring) ---

    @(link_name = "wgpuCommandEncoderResolveQuerySet")
    command_encoder_resolve_query_set :: proc(command_encoder: CommandEncoder, query_set: QuerySet, first_query: u32, query_count: u32, destination: Buffer, destination_offset: u64) ---

    @(link_name = "wgpuCommandEncoderSetLabel")
    command_encoder_set_label :: proc(command_encoder: CommandEncoder, label: cstring) ---

    @(link_name = "wgpuCommandEncoderWriteTimestamp")
    command_encoder_write_timestamp :: proc(command_encoder: CommandEncoder, query_set: QuerySet, query_index: u32) ---

    @(link_name = "wgpuCommandEncoderReference")
    command_encoder_reference :: proc(command_encoder: CommandEncoder) ---

    @(link_name = "wgpuCommandEncoderRelease")
    command_encoder_release :: proc(command_encoder: CommandEncoder) ---

    @(link_name = "wgpuComputePassEncoderBeginPipelineStatisticsQuery")
    compute_pass_encoder_begin_pipeline_statistics_query :: proc(compute_pass_encoder: ComputePassEncoder, query_set: QuerySet, query_index: u32) ---

    @(link_name = "wgpuComputePassEncoderDispatchWorkgroups")
    compute_pass_encoder_dispatch_workgroups :: proc(compute_pass_encoder: ComputePassEncoder, workgroup_count_x: u32, workgroup_count_y: u32, workgroup_count_z: u32) ---

    @(link_name = "wgpuComputePassEncoderDispatchWorkgroupsIndirect")
    compute_pass_encoder_dispatch_workgroups_indirect :: proc(compute_pass_encoder: ComputePassEncoder, indirect_buffer: Buffer, indirect_offset: u64) ---

    @(link_name = "wgpuComputePassEncoderEnd")
    compute_pass_encoder_end :: proc(compute_pass_encoder: ComputePassEncoder) ---

    @(link_name = "wgpuComputePassEncoderEndPipelineStatisticsQuery")
    compute_pass_encoder_end_pipeline_statistics_query :: proc(compute_pass_encoder: ComputePassEncoder) ---

    @(link_name = "wgpuComputePassEncoderInsertDebugMarker")
    compute_pass_encoder_insert_debug_marker :: proc(compute_pass_encoder: ComputePassEncoder, marker_label: cstring) ---

    @(link_name = "wgpuComputePassEncoderPopDebugGroup")
    compute_pass_encoder_pop_debug_group :: proc(compute_pass_encoder: ComputePassEncoder) ---

    @(link_name = "wgpuComputePassEncoderPushDebugGroup")
    compute_pass_encoder_push_debug_group :: proc(compute_pass_encoder: ComputePassEncoder, group_label: cstring) ---

    @(link_name = "wgpuComputePassEncoderSetBindGroup")
    compute_pass_encoder_set_bind_group :: proc(compute_pass_encoder: ComputePassEncoder, group_index: u32, group: BindGroup, dynamic_offset_count: _c.size_t, #by_ptr dynamic_offsets: u32) ---

    @(link_name = "wgpuComputePassEncoderSetLabel")
    compute_pass_encoder_set_label :: proc(compute_pass_encoder: ComputePassEncoder, label: cstring) ---

    @(link_name = "wgpuComputePassEncoderSetPipeline")
    compute_pass_encoder_set_pipeline :: proc(compute_pass_encoder: ComputePassEncoder, pipeline: ComputePipeline) ---

    @(link_name = "wgpuComputePassEncoderReference")
    compute_pass_encoder_reference :: proc(compute_pass_encoder: ComputePassEncoder) ---

    @(link_name = "wgpuComputePassEncoderRelease")
    compute_pass_encoder_release :: proc(compute_pass_encoder: ComputePassEncoder) ---

    @(link_name = "wgpuComputePipelineGetBindGroupLayout")
    compute_pipeline_get_bind_group_layout :: proc(compute_pipeline: ComputePipeline, group_index: u32) -> BindGroupLayout ---

    @(link_name = "wgpuComputePipelineSetLabel")
    compute_pipeline_set_label :: proc(compute_pipeline: ComputePipeline, label: cstring) ---

    @(link_name = "wgpuComputePipelineReference")
    compute_pipeline_reference :: proc(compute_pipeline: ComputePipeline) ---

    @(link_name = "wgpuComputePipelineRelease")
    compute_pipeline_release :: proc(compute_pipeline: ComputePipeline) ---

    @(link_name = "wgpuDeviceCreateBindGroup")
    device_create_bind_group :: proc(device: Device, #by_ptr descriptor: BindGroupDescriptor) -> BindGroup ---

    @(link_name = "wgpuDeviceCreateBindGroupLayout")
    device_create_bind_group_layout :: proc(device: Device, #by_ptr descriptor: BindGroupLayoutDescriptor) -> BindGroupLayout ---

    @(link_name = "wgpuDeviceCreateBuffer")
    device_create_buffer :: proc(device: Device, #by_ptr descriptor: BufferDescriptor) -> Buffer ---

    @(link_name = "wgpuDeviceCreateCommandEncoder")
    device_create_command_encoder :: proc(device: Device, #by_ptr descriptor: CommandEncoderDescriptor) -> CommandEncoder ---

    @(link_name = "wgpuDeviceCreateComputePipeline")
    device_create_compute_pipeline :: proc(device: Device, #by_ptr descriptor: ComputePipelineDescriptor) -> ComputePipeline ---

    @(link_name = "wgpuDeviceCreateComputePipelineAsync")
    device_create_compute_pipeline_async :: proc(device: Device, #by_ptr descriptor: ComputePipelineDescriptor, callback: CreateComputePipelineAsyncCallback, userdata: rawptr) ---

    @(link_name = "wgpuDeviceCreatePipelineLayout")
    device_create_pipeline_layout :: proc(device: Device, #by_ptr descriptor: PipelineLayoutDescriptor) -> PipelineLayout ---

    @(link_name = "wgpuDeviceCreateQuerySet")
    device_create_query_set :: proc(device: Device, #by_ptr descriptor: QuerySetDescriptor) -> QuerySet ---

    @(link_name = "wgpuDeviceCreateRenderBundleEncoder")
    device_create_render_bundle_encoder :: proc(device: Device, #by_ptr descriptor: RenderBundleEncoderDescriptor) -> RenderBundleEncoder ---

    @(link_name = "wgpuDeviceCreateRenderPipeline")
    device_create_render_pipeline :: proc(device: Device, #by_ptr descriptor: RenderPipelineDescriptor) -> RenderPipeline ---

    @(link_name = "wgpuDeviceCreateRenderPipelineAsync")
    device_create_render_pipeline_async :: proc(device: Device, #by_ptr descriptor: RenderPipelineDescriptor, callback: CreateRenderPipelineAsyncCallback, userdata: rawptr) ---

    @(link_name = "wgpuDeviceCreateSampler")
    device_create_sampler :: proc(device: Device, #by_ptr descriptor: SamplerDescriptor) -> Sampler ---

    @(link_name = "wgpuDeviceCreateShaderModule")
    device_create_shader_module :: proc(device: Device, #by_ptr descriptor: ShaderModuleDescriptor) -> ShaderModule ---

    @(link_name = "wgpuDeviceCreateSwapChain")
    device_create_swap_chain :: proc(device: Device, surface: Surface, #by_ptr descriptor: SwapChainDescriptor) -> SwapChain ---

    @(link_name = "wgpuDeviceCreateTexture")
    device_create_texture :: proc(device: Device, #by_ptr descriptor: TextureDescriptor) -> Texture ---

    @(link_name = "wgpuDeviceDestroy")
    device_destroy :: proc(device: Device) ---

    @(link_name = "wgpuDeviceGetQueue")
    device_get_queue :: proc(device: Device) -> Queue ---

    @(link_name = "wgpuDeviceHasFeature")
    device_has_feature :: proc(device: Device, feature: FeatureName) -> bool ---

    @(link_name = "wgpuDevicePopErrorScope")
    device_pop_error_scope :: proc(device: Device, callback: ErrorCallback, userdata: rawptr) ---

    @(link_name = "wgpuDevicePushErrorScope")
    device_push_error_scope :: proc(device: Device, filter: ErrorFilter) ---

    @(link_name = "wgpuDeviceSetLabel")
    device_set_label :: proc(device: Device, label: cstring) ---

    @(link_name = "wgpuDeviceSetUncapturedErrorCallback")
    device_set_uncaptured_error_callback :: proc(device: Device, callback: ErrorCallback, userdata: rawptr) ---

    @(link_name = "wgpuDeviceReference")
    device_reference :: proc(device: Device) ---

    @(link_name = "wgpuDeviceRelease")
    device_release :: proc(device: Device) ---

    @(link_name = "wgpuInstanceCreateSurface")
    instance_create_surface :: proc(instance: Instance, #by_ptr descriptor: SurfaceDescriptor) -> Surface ---

    @(link_name = "wgpuInstanceProcessEvents")
    instance_process_events :: proc(instance: Instance) ---

    @(link_name = "wgpuInstanceRequestAdapter")
    instance_request_adapter :: proc(instance: Instance, #by_ptr options: RequestAdapterOptions, callback: RequestAdapterCallback, userdata: rawptr) ---

    @(link_name = "wgpuInstanceReference")
    instance_reference :: proc(instance: Instance) ---

    @(link_name = "wgpuInstanceRelease")
    instance_release :: proc(instance: Instance) ---

    @(link_name = "wgpuPipelineLayoutSetLabel")
    pipeline_layout_set_label :: proc(pipeline_layout: PipelineLayout, label: cstring) ---

    @(link_name = "wgpuPipelineLayoutReference")
    pipeline_layout_reference :: proc(pipeline_layout: PipelineLayout) ---

    @(link_name = "wgpuPipelineLayoutRelease")
    pipeline_layout_release :: proc(pipeline_layout: PipelineLayout) ---

    @(link_name = "wgpuQuerySetDestroy")
    query_set_destroy :: proc(query_set: QuerySet) ---

    @(link_name = "wgpuQuerySetGetCount")
    query_set_get_count :: proc(query_set: QuerySet) -> u32 ---

    @(link_name = "wgpuQuerySetGetType")
    query_set_get_type :: proc(query_set: QuerySet) -> QueryType ---

    @(link_name = "wgpuQuerySetSetLabel")
    query_set_set_label :: proc(query_set: QuerySet, label: cstring) ---

    @(link_name = "wgpuQuerySetReference")
    query_set_reference :: proc(query_set: QuerySet) ---

    @(link_name = "wgpuQuerySetRelease")
    query_set_release :: proc(query_set: QuerySet) ---

    @(link_name = "wgpuQueueOnSubmittedWorkDone")
    queue_on_submitted_work_done :: proc(queue: Queue, callback: QueueWorkDoneCallback, userdata: rawptr) ---

    @(link_name = "wgpuQueueSetLabel")
    queue_set_label :: proc(queue: Queue, label: cstring) ---

    @(link_name = "wgpuQueueWriteTexture")
    queue_write_texture :: proc(queue: Queue, #by_ptr destination: ImageCopyTexture, data: rawptr, data_size: _c.size_t, #by_ptr data_layout: TextureDataLayout, #by_ptr write_size: Extent3D) ---

    @(link_name = "wgpuQueueReference")
    queue_reference :: proc(queue: Queue) ---

    @(link_name = "wgpuQueueRelease")
    queue_release :: proc(queue: Queue) ---

    @(link_name = "wgpuRenderBundleSetLabel")
    render_bundle_set_label :: proc(render_bundle: RenderBundle, label: cstring) ---

    @(link_name = "wgpuRenderBundleReference")
    render_bundle_reference :: proc(render_bundle: RenderBundle) ---

    @(link_name = "wgpuRenderBundleRelease")
    render_bundle_release :: proc(render_bundle: RenderBundle) ---

    @(link_name = "wgpuRenderBundleEncoderDraw")
    render_bundle_encoder_draw :: proc(render_bundle_encoder: RenderBundleEncoder, vertex_count: u32, instance_count: u32, first_vertex: u32, first_instance: u32) ---

    @(link_name = "wgpuRenderBundleEncoderDrawIndexed")
    render_bundle_encoder_draw_indexed :: proc(render_bundle_encoder: RenderBundleEncoder, index_count: u32, instance_count: u32, first_index: u32, base_vertex: i32, first_instance: u32) ---

    @(link_name = "wgpuRenderBundleEncoderDrawIndexedIndirect")
    render_bundle_encoder_draw_indexed_indirect :: proc(render_bundle_encoder: RenderBundleEncoder, indirect_buffer: Buffer, indirect_offset: u64) ---

    @(link_name = "wgpuRenderBundleEncoderDrawIndirect")
    render_bundle_encoder_draw_indirect :: proc(render_bundle_encoder: RenderBundleEncoder, indirect_buffer: Buffer, indirect_offset: u64) ---

    @(link_name = "wgpuRenderBundleEncoderFinish")
    render_bundle_encoder_finish :: proc(render_bundle_encoder: RenderBundleEncoder, #by_ptr descriptor: RenderBundleDescriptor) -> RenderBundle ---

    @(link_name = "wgpuRenderBundleEncoderInsertDebugMarker")
    render_bundle_encoder_insert_debug_marker :: proc(render_bundle_encoder: RenderBundleEncoder, marker_label: cstring) ---

    @(link_name = "wgpuRenderBundleEncoderPopDebugGroup")
    render_bundle_encoder_pop_debug_group :: proc(render_bundle_encoder: RenderBundleEncoder) ---

    @(link_name = "wgpuRenderBundleEncoderPushDebugGroup")
    render_bundle_encoder_push_debug_group :: proc(render_bundle_encoder: RenderBundleEncoder, group_label: cstring) ---

    @(link_name = "wgpuRenderBundleEncoderSetBindGroup")
    render_bundle_encoder_set_bind_group :: proc(render_bundle_encoder: RenderBundleEncoder, group_index: u32, group: BindGroup, dynamic_offset_count: _c.size_t, dynamic_offsets: [^]u32) ---

    @(link_name = "wgpuRenderBundleEncoderSetIndexBuffer")
    render_bundle_encoder_set_index_buffer :: proc(render_bundle_encoder: RenderBundleEncoder, buffer: Buffer, format: IndexFormat, offset: u64, size: u64) ---

    @(link_name = "wgpuRenderBundleEncoderSetLabel")
    render_bundle_encoder_set_label :: proc(render_bundle_encoder: RenderBundleEncoder, label: cstring) ---

    @(link_name = "wgpuRenderBundleEncoderSetPipeline")
    render_bundle_encoder_set_pipeline :: proc(render_bundle_encoder: RenderBundleEncoder, pipeline: RenderPipeline) ---

    @(link_name = "wgpuRenderBundleEncoderSetVertexBuffer")
    render_bundle_encoder_set_vertex_buffer :: proc(render_bundle_encoder: RenderBundleEncoder, slot: u32, buffer: Buffer, offset: u64, size: u64) ---

    @(link_name = "wgpuRenderBundleEncoderReference")
    render_bundle_encoder_reference :: proc(render_bundle_encoder: RenderBundleEncoder) ---

    @(link_name = "wgpuRenderBundleEncoderRelease")
    render_bundle_encoder_release :: proc(render_bundle_encoder: RenderBundleEncoder) ---

    @(link_name = "wgpuRenderPassEncoderBeginOcclusionQuery")
    render_pass_encoder_begin_occlusion_query :: proc(render_pass_encoder: RenderPassEncoder, query_index: u32) ---

    @(link_name = "wgpuRenderPassEncoderBeginPipelineStatisticsQuery")
    render_pass_encoder_begin_pipeline_statistics_query :: proc(render_pass_encoder: RenderPassEncoder, query_set: QuerySet, query_index: u32) ---

    @(link_name = "wgpuRenderPassEncoderDraw")
    render_pass_encoder_draw :: proc(render_pass_encoder: RenderPassEncoder, vertex_count: u32, instance_count: u32, first_vertex: u32, first_instance: u32) ---

    @(link_name = "wgpuRenderPassEncoderDrawIndexed")
    render_pass_encoder_draw_indexed :: proc(render_pass_encoder: RenderPassEncoder, index_count: u32, instance_count: u32, first_index: u32, base_vertex: i32, first_instance: u32) ---

    @(link_name = "wgpuRenderPassEncoderDrawIndexedIndirect")
    render_pass_encoder_draw_indexed_indirect :: proc(render_pass_encoder: RenderPassEncoder, indirect_buffer: Buffer, indirect_offset: u64) ---

    @(link_name = "wgpuRenderPassEncoderDrawIndirect")
    render_pass_encoder_draw_indirect :: proc(render_pass_encoder: RenderPassEncoder, indirect_buffer: Buffer, indirect_offset: u64) ---

    @(link_name = "wgpuRenderPassEncoderEnd")
    render_pass_encoder_end :: proc(render_pass_encoder: RenderPassEncoder) ---

    @(link_name = "wgpuRenderPassEncoderEndOcclusionQuery")
    render_pass_encoder_end_occlusion_query :: proc(render_pass_encoder: RenderPassEncoder) ---

    @(link_name = "wgpuRenderPassEncoderEndPipelineStatisticsQuery")
    render_pass_encoder_end_pipeline_statistics_query :: proc(render_pass_encoder: RenderPassEncoder) ---

    @(link_name = "wgpuRenderPassEncoderExecuteBundles")
    render_pass_encoder_execute_bundles :: proc(render_pass_encoder: RenderPassEncoder, bundle_count: _c.size_t, bundles: [^]RenderBundle) ---

    @(link_name = "wgpuRenderPassEncoderInsertDebugMarker")
    render_pass_encoder_insert_debug_marker :: proc(render_pass_encoder: RenderPassEncoder, marker_label: cstring) ---

    @(link_name = "wgpuRenderPassEncoderPopDebugGroup")
    render_pass_encoder_pop_debug_group :: proc(render_pass_encoder: RenderPassEncoder) ---

    @(link_name = "wgpuRenderPassEncoderPushDebugGroup")
    render_pass_encoder_push_debug_group :: proc(render_pass_encoder: RenderPassEncoder, group_label: cstring) ---

    @(link_name = "wgpuRenderPassEncoderSetBindGroup")
    render_pass_encoder_set_bind_group :: proc(render_pass_encoder: RenderPassEncoder, group_index: u32, group: BindGroup, dynamic_offset_count: _c.size_t, dynamic_offsets: [^]u32) ---

    @(link_name = "wgpuRenderPassEncoderSetBlendConstant")
    render_pass_encoder_set_blend_constant :: proc(render_pass_encoder: RenderPassEncoder, #by_ptr color: Color) ---

    @(link_name = "wgpuRenderPassEncoderSetIndexBuffer")
    render_pass_encoder_set_index_buffer :: proc(render_pass_encoder: RenderPassEncoder, buffer: Buffer, format: IndexFormat, offset: u64, size: u64) ---

    @(link_name = "wgpuRenderPassEncoderSetLabel")
    render_pass_encoder_set_label :: proc(render_pass_encoder: RenderPassEncoder, label: cstring) ---

    @(link_name = "wgpuRenderPassEncoderSetPipeline")
    render_pass_encoder_set_pipeline :: proc(render_pass_encoder: RenderPassEncoder, pipeline: RenderPipeline) ---

    @(link_name = "wgpuRenderPassEncoderSetScissorRect")
    render_pass_encoder_set_scissor_rect :: proc(render_pass_encoder: RenderPassEncoder, x: u32, y: u32, width: u32, height: u32) ---

    @(link_name = "wgpuRenderPassEncoderSetStencilReference")
    render_pass_encoder_set_stencil_reference :: proc(render_pass_encoder: RenderPassEncoder, reference: u32) ---

    @(link_name = "wgpuRenderPassEncoderSetVertexBuffer")
    render_pass_encoder_set_vertex_buffer :: proc(render_pass_encoder: RenderPassEncoder, slot: u32, buffer: Buffer, offset: u64, size: u64) ---

    @(link_name = "wgpuRenderPassEncoderSetViewport")
    render_pass_encoder_set_viewport :: proc(render_pass_encoder: RenderPassEncoder, x: _c.float, y: _c.float, width: _c.float, height: _c.float, min_depth: _c.float, max_depth: _c.float) ---

    @(link_name = "wgpuRenderPassEncoderReference")
    render_pass_encoder_reference :: proc(render_pass_encoder: RenderPassEncoder) ---

    @(link_name = "wgpuRenderPassEncoderRelease")
    render_pass_encoder_release :: proc(render_pass_encoder: RenderPassEncoder) ---

    @(link_name = "wgpuRenderPipelineGetBindGroupLayout")
    render_pipeline_get_bind_group_layout :: proc(render_pipeline: RenderPipeline, group_index: u32) -> BindGroupLayout ---

    @(link_name = "wgpuRenderPipelineSetLabel")
    render_pipeline_set_label :: proc(render_pipeline: RenderPipeline, label: cstring) ---

    @(link_name = "wgpuRenderPipelineReference")
    render_pipeline_reference :: proc(render_pipeline: RenderPipeline) ---

    @(link_name = "wgpuRenderPipelineRelease")
    render_pipeline_release :: proc(render_pipeline: RenderPipeline) ---

    @(link_name = "wgpuSamplerSetLabel")
    sampler_set_label :: proc(sampler: Sampler, label: cstring) ---

    @(link_name = "wgpuSamplerReference")
    sampler_reference :: proc(sampler: Sampler) ---

    @(link_name = "wgpuSamplerRelease")
    sampler_release :: proc(sampler: Sampler) ---

    @(link_name = "wgpuShaderModuleGetCompilationInfo")
    shader_module_get_compilation_info :: proc(shader_module: ShaderModule, callback: CompilationInfoCallback, userdata: rawptr) ---

    @(link_name = "wgpuShaderModuleSetLabel")
    shader_module_set_label :: proc(shader_module: ShaderModule, label: cstring) ---

    @(link_name = "wgpuShaderModuleReference")
    shader_module_reference :: proc(shader_module: ShaderModule) ---

    @(link_name = "wgpuShaderModuleRelease")
    shader_module_release :: proc(shader_module: ShaderModule) ---

    @(link_name = "wgpuSurfaceGetPreferredFormat")
    surface_get_preferred_format :: proc(surface: Surface, adapter: Adapter) -> TextureFormat ---

    @(link_name = "wgpuSurfaceReference")
    surface_reference :: proc(surface: Surface) ---

    @(link_name = "wgpuSurfaceRelease")
    surface_release :: proc(surface: Surface) ---

    @(link_name = "wgpuSwapChainGetCurrentTextureView")
    swap_chain_get_current_texture_view :: proc(swap_chain: SwapChain) -> TextureView ---

    @(link_name = "wgpuSwapChainPresent")
    swap_chain_present :: proc(swap_chain: SwapChain) ---

    @(link_name = "wgpuSwapChainReference")
    swap_chain_reference :: proc(swap_chain: SwapChain) ---

    @(link_name = "wgpuSwapChainRelease")
    swap_chain_release :: proc(swap_chain: SwapChain) ---

    @(link_name = "wgpuTextureCreateView")
    texture_create_view :: proc(texture: Texture, #by_ptr descriptor: TextureViewDescriptor) -> TextureView ---

    @(link_name = "wgpuTextureDestroy")
    texture_destroy :: proc(texture: Texture) ---

    @(link_name = "wgpuTextureGetDepthOrArrayLayers")
    texture_get_depth_or_array_layers :: proc(texture: Texture) -> u32 ---

    @(link_name = "wgpuTextureGetDimension")
    texture_get_dimension :: proc(texture: Texture) -> TextureDimension ---

    @(link_name = "wgpuTextureGetFormat")
    texture_get_format :: proc(texture: Texture) -> TextureFormat ---

    @(link_name = "wgpuTextureGetHeight")
    texture_get_height :: proc(texture: Texture) -> u32 ---

    @(link_name = "wgpuTextureGetMipLevelCount")
    texture_get_mip_level_count :: proc(texture: Texture) -> u32 ---

    @(link_name = "wgpuTextureGetSampleCount")
    texture_get_sample_count :: proc(texture: Texture) -> u32 ---

    @(link_name = "wgpuTextureGetUsage")
    texture_get_usage :: proc(texture: Texture) -> u32 ---

    @(link_name = "wgpuTextureGetWidth")
    texture_get_width :: proc(texture: Texture) -> u32 ---

    @(link_name = "wgpuTextureSetLabel")
    texture_set_label :: proc(texture: Texture, label: cstring) ---

    @(link_name = "wgpuTextureReference")
    texture_reference :: proc(texture: Texture) ---

    @(link_name = "wgpuTextureRelease")
    texture_release :: proc(texture: Texture) ---

    @(link_name = "wgpuTextureViewSetLabel")
    texture_view_set_label :: proc(texture_view: TextureView, label: cstring) ---

    @(link_name = "wgpuTextureViewReference")
    texture_view_reference :: proc(texture_view: TextureView) ---

    @(link_name = "wgpuTextureViewRelease")
    texture_view_release :: proc(texture_view: TextureView) ---

}
when WGPU_NATIVE {
    @(default_calling_convention = "c")
    foreign wgpu {
        @(link_name = "wgpuGenerateReport")
        generate_report :: proc(instance: Instance, report: ^GlobalReport) ---

        @(link_name = "wgpuDevicePoll")
        device_poll :: proc(device: Device, wait: bool, #by_ptr wrapped_submission_index: WrappedSubmissionIndex) -> bool ---

        @(link_name = "wgpuSetLogCallback")
        set_log_callback :: proc(callback: LogCallback, userdata: rawptr) ---

        @(link_name = "wgpuSetLogLevel")
        set_log_level :: proc(level: LogLevel) ---

        @(link_name = "wgpuGetVersion")
        get_version :: proc() -> u32 ---

        @(link_name = "wgpuRenderPassEncoderSetPushConstants")
        render_pass_encoder_set_push_constants :: proc(encoder: RenderPassEncoder, stages: u32, offset: u32, size_bytes: u32, data: rawptr) ---

        @(link_name = "wgpuRenderPassEncoderMultiDrawIndirect")
        render_pass_encoder_multi_draw_indirect :: proc(encoder: RenderPassEncoder, buffer: Buffer, offset: u64, count: u32) ---

        @(link_name = "wgpuRenderPassEncoderMultiDrawIndexedIndirect")
        render_pass_encoder_multi_draw_indexed_indirect :: proc(encoder: RenderPassEncoder, buffer: Buffer, offset: u64, count: u32) ---

        @(link_name = "wgpuRenderPassEncoderMultiDrawIndirectCount")
        render_pass_encoder_multi_draw_indirect_count :: proc(encoder: RenderPassEncoder, buffer: Buffer, offset: u64, count_buffer: Buffer, count_buffer_offset: u64, max_count: u32) ---

        @(link_name = "wgpuRenderPassEncoderMultiDrawIndexedIndirectCount")
        render_pass_encoder_multi_draw_indexed_indirect_count :: proc(encoder: RenderPassEncoder, buffer: Buffer, offset: u64, count_buffer: Buffer, count_buffer_offset: u64, max_count: u32) ---
    }
}
