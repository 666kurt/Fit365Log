import SwiftUI

struct AlertView: View {
    
    @Binding var showAlert: Bool
    let title: String
    let description: String
    let onReset: () -> Void
    
    var body: some View {
        ZStack {
            
            Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Text(title)
                    .font(.headline)
                    .padding(.top)
                    .padding(.bottom, 8)
                
                Text(description)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding([.bottom, .trailing, .leading])
                
                Divider()
                    .background(Color(hex: "#8C8C8C"))
                
                    
                    Button {
                        onReset()
                        showAlert = false
                    } label: {
                        Text("Reset")
                            .font(.headline).fontWeight(.semibold)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color.theme.text.second)
                            .padding(.vertical, 11)
                    }
                    
                    Divider()
                        .background(Color(hex: "#8C8C8C"))
                    
                    Button {
                        showAlert = false
                    } label: {
                        Text("Close")
                            .font(.headline)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color.theme.text.notActive)
                            .padding(.vertical, 11)
                    }

            }
            .foregroundColor(Color.theme.text.main)
            .zIndex(1)
            .frame(maxWidth: 270, alignment: .center)
            .background(
                Color(hex: "#252525")
            )
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}

#Preview {
    AlertView(showAlert: .constant(true),
              title: "Reset progress",
              description: "This will result in complete data loss, are you sure?",
              onReset: {})
}
