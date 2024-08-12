import SwiftUI

struct NavigationTitleView: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .foregroundColor(Color.theme.text.main)
            .font(.largeTitle.weight(.bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 20)
    }
    
}
