import SwiftUI

struct CustomVStackModifier: ViewModifier {
    func body(content: Content) -> some View {
        
        content
        
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.theme.background.main.ignoresSafeArea())
            .navigationBarBackButtonHidden()
    }
}

extension View {
    func customVStackStyle() -> some View {
        self.modifier(CustomVStackModifier())
    }
}
