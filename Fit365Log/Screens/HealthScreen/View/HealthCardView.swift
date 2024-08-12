import SwiftUI

struct HealthCardView: View {
    
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title3.weight(.semibold))
                .foregroundColor(Color.theme.text.second)
            Text(value)
                .font(.subheadline)
                .foregroundColor(Color.theme.background.second)
            
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
        .padding(.bottom, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.theme.background.light)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
}

#Preview {
    HealthCardView(title: "Age", value: "12")
        .padding()
}

