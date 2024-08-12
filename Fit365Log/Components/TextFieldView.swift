import SwiftUI

struct TextFieldView: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 15) {
            Text(placeholder)
                .font(.body.weight(.semibold))
                .foregroundColor(Color.theme.text.main)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text("Value")
                        .font(.callout)
                        .foregroundColor(
                            text.isEmpty ? Color.theme.text.notActive : Color.theme.text.main
                        )
                }
                TextField("", text: $text)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .foregroundColor(Color.theme.text.main)
        .background(Color.theme.background.light)
        .clipShape(RoundedRectangle(cornerRadius: 10))

    }
}

#Preview {
    TextFieldView(placeholder: "Name",
                  text: .constant(""))
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.theme.background.main)
}
