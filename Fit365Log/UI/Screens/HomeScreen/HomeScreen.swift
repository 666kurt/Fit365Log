import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Welcome")
                .foregroundColor(.theme.text.main)
                .font(.system(size: 34, weight: .black))
            
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 20) {
                    ForEach(1...10, id: \.self) { index in
                        Image("\(index)")
                            .resizable()
                            .scaledToFill()
                    }
                }
            }
        }
        .customVStackStyle()
    }
}

#Preview {
    HomeScreen()
}
