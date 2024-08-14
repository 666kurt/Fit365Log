import SwiftUI

struct CustomSheet<Content: View>: View {
    
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack {
           Text(title)
                .foregroundColor(Color.theme.text.main)
                .font(.headline)
                .padding(.vertical, 20)
            
            content
        }
        .customVStackStyle()
        .onTapGesture {
            UIApplication.shared.endEditing(true)
        }
    }

}

