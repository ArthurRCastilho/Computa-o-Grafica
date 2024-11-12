import Cocoa
import MetalKit

class ViewController: NSViewController {
    var mtkView: MTKView!
    var renderer: Renderer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuração do MTKView
        mtkView = MTKView(frame: view.bounds)
        mtkView.device = MTLCreateSystemDefaultDevice()
        mtkView.colorPixelFormat = .bgra8Unorm
        mtkView.clearColor = MTLClearColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0) // Fundo escuro e opaco
        view.addSubview(mtkView)

        // Configura o renderer
        renderer = Renderer(mtkView: mtkView)
        mtkView.delegate = renderer
    }
    
    override func keyDown(with event: NSEvent) {
        // Passa o evento de tecla pressionada para o renderer
        renderer.handleKeyDown(event: event)
    }

}

