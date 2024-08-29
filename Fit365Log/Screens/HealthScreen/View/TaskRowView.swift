import SwiftUI

struct TaskRowView: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack() {
                Text(title)
                    .lineLimit(1)
                Spacer()
                Button {
                    action()
                } label: {
                    Text("Done")
                        .fontWeight(.bold)
                        .padding(.horizontal, 60)
                        .padding(.vertical, 10)
                        .background(Color.theme.other.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .foregroundColor(.white)
                }
            }
            .foregroundColor(Color.theme.text.main)
            .padding(.vertical, 19)
            .frame(maxWidth: .infinity)
            
            Divider()
                .frame(height: 1)
                .background(Color.theme.background.second)
        }
    }
    
}

#Preview {
    TaskRowView(title: "See an endocrinologist", action: {})
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.theme.background.main)
}
