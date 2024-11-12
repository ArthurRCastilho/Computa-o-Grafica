#include <metal_stdlib>
using namespace metal;

struct VertexOut {
    float4 position [[position]];
    float4 color;
};

struct Uniforms {
    float4x4 modelMatrix;
    float4 color;
};

// Vertex Shader
// Criação do Cubo
vertex VertexOut vertex_main(uint vertexID [[vertex_id]], constant Uniforms &uniforms [[buffer(1)]]) {
    float4 positions[6] = {
        float4(-0.5, 0.5, 0.0, 1.0),  // Top-left
        float4(-0.5, -0.5, 0.0, 1.0), // Bottom-left
        float4(0.5, -0.5, 0.0, 1.0),  // Bottom-right
        float4(-0.5, 0.5, 0.0, 1.0),  // Top-left
        float4(0.5, -0.5, 0.0, 1.0),  // Bottom-right
        float4(0.5, 0.5, 0.0, 1.0)    // Top-right
    };

    VertexOut out;
    out.position = uniforms.modelMatrix * positions[vertexID];
    out.color = uniforms.color;
    return out;
}

// Fragment Shader
fragment float4 fragment_main(VertexOut in [[stage_in]], constant Uniforms &uniforms [[buffer(1)]]) {
    return uniforms.color;
}

