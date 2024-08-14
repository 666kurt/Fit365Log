import SwiftUI

struct OrientationReader: ViewModifier {
    @Binding var isLandscape: Bool
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .onAppear {
                    updateOrientation(geometry: geometry)
                }
                .onChange(of: geometry.size) { _ in
                    updateOrientation(geometry: geometry)
                }
        }
    }
    
    private func updateOrientation(geometry: GeometryProxy) {
        isLandscape = geometry.size.width > geometry.size.height
    }
}

extension View {
    func orientationReader(isLandscape: Binding<Bool>) -> some View {
        self.modifier(OrientationReader(isLandscape: isLandscape))
    }
}
