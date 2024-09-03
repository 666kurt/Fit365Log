import SwiftUI

enum Screens {
    case home
    case health
    case training
    case profile
}


final class Router: ObservableObject {
    
    static let shared = Router()
    private init() {}
    
    @Published var selectedScreen: Screens = .home
    
}
