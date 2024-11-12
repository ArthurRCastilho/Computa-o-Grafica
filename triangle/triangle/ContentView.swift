import SwiftUI
import CoreData
import MetalKit

struct ContentView: UIViewRepresentable {
    @Environment(\.managedObjectContext) private var viewContext
    
    func makeCoordinator() -> Renderer {
        Renderer(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<ContentView>) -> MTKView {
        let mtkView = MTKView()
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 60
        mtkView.enableSetNeedsDisplay = true
        
        if let metalDevice = MTLCreateSystemDefaultDevice() {
            mtkView.device = metalDevice
        }
        
        mtkView.framebufferOnly = false
        mtkView.drawableSize = mtkView.frame.size
        
        return mtkView
    }
    
    func updateUIView (_ uiView: MTKView, context: UIViewRepresentableContext<ContentView>){
        
    }


}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
