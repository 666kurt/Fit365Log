import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
    
    var components: (r: Double, g: Double, b: Double, a: Double) {
        
        typealias NativeColor = UIColor
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else { return (0,0,0,0) }
        
        return (Double(r), Double(g), Double(b), Double(a))
    }
    
    static let theme = ColorTheme()
}

struct ColorTheme {
    
    struct TextColors {
        let main = Color("textMain")
        let second = Color("textSecond")
        let notActive = Color("textNotActive")
    }
    
    struct BackgroundColors {
        let main = Color("bgMain")
        let second = Color("bgSecond")
        let light = Color("bgLight")
    }
    
    struct OtherColors {
        let primary = Color("main")
        let secondary = Color("second")
        let separator = Color("divider")
    }
    
    let text = TextColors()
    let background = BackgroundColors()
    let other = OtherColors()
    
}
