import SwiftUI

struct ToolBarView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let label: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back home")
                }
                .font(.headline)
                .foregroundColor(Color.theme.text.second)
            }
            
            Spacer()
            
            Button {
                action()
            } label: {
                Text(label)
                    .font(.headline)
                    .foregroundColor(Color.theme.text.second)
            }
        }
        .padding(.vertical, 10)
    }
}
