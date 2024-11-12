import MetalKit
import simd

class Renderer: NSObject, MTKViewDelegate {
    var device: MTLDevice!
    var commandQueue: MTLCommandQueue!
    var pipelineState: MTLRenderPipelineState!
    var rotationAngle: Float = 0.0
    var color: SIMD4<Float> = SIMD4<Float>(1.0, 0.0, 0.0, 1.0) // Cor inicial (vermelho)

    struct Uniforms {
        var modelMatrix: float4x4
        var color: SIMD4<Float>
    }
    
    init(mtkView: MTKView) {
        super.init()
        device = mtkView.device
        commandQueue = device.makeCommandQueue()
        
        // Load shader functions
        let library = device.makeDefaultLibrary()!
        let vertexFunction = library.makeFunction(name: "vertex_main")
        let fragmentFunction = library.makeFunction(name: "fragment_main")
        
        // Configure pipeline
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = mtkView.colorPixelFormat
        
        pipelineState = try! device.makeRenderPipelineState(descriptor: pipelineDescriptor)
    }

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}

    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
              let descriptor = view.currentRenderPassDescriptor else { return }

        let commandBuffer = commandQueue.makeCommandBuffer()!
        let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: descriptor)!
        
        // Cria a matriz de rotação
        let rotationMatrix = float4x4(rotationZ: rotationAngle)
        
        // Configura os uniforms
        var uniforms = Uniforms(modelMatrix: rotationMatrix, color: color)
        
        // Envia os dados ao shader
        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBytes(&uniforms, length: MemoryLayout<Uniforms>.stride, index: 1)
        renderEncoder.setFragmentBytes(&uniforms, length: MemoryLayout<Uniforms>.stride, index: 1)
        renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 6)
        renderEncoder.endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }

    func handleKeyDown(event: NSEvent) {
        // Switch case para input de cada tecla
        switch event.keyCode {
        case 2: // Tecla "D"
            rotationAngle += 0.02
        case 13: // Tecla "W"
            color = SIMD4(Float.random(in: 0...1), Float.random(in: 0...1), Float.random(in: 0...1), 1.0)
        default:
            break
        }
    }
}

