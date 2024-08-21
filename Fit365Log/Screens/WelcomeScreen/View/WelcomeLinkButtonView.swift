import SwiftUI

struct WelcomeLinkButtonView: View {
    
    let image: String
    let title: String
    let url: String
    
    var body: some View {
        Link(destination: URL(string: url)!, label: {
            HStack(spacing: 10) {
                Image(systemName: image)
                    .frame(width: 28)
                    .foregroundColor(Color.theme.text.second)
                Text(title)
                    .font(.body).bold()
                    .foregroundColor(Color.theme.text.main)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.title3)
                    .foregroundColor(Color.theme.text.main)
            }
            .frame(maxWidth: .infinity)
            .padding(15)
            .background(Color.theme.background.light)
        .clipShape(Capsule())
        })
    }
}

#Preview {
    WelcomeLinkButtonView(image: "bubble.fill", title: "Contact us", url: "https://google.com")
        .padding()
}
