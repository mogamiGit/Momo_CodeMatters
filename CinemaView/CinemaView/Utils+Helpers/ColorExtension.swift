
import SwiftUI

extension Color {
    
    public static var random: Color {
        return Color(RGBColorSpace.sRGB, red: Double.random(in: 0...255) / 255.0,
                     green: Double.random(in: 0...255) / 255.0,
                     blue: Double.random(in: 0...255) / 255.0,
                     opacity: 1.0)
    }
    
    public static var randomGray: Color {
        let component = Double.random(in: 0...255) / 255.0
        return Color(RGBColorSpace.sRGB, red: component,
                     green: component,
                     blue: component,
                     opacity: 1.0)
    }

    static func hex(_ hex: String) -> Self {
        
        let scanner = Scanner(string: hex)
        scanner.currentIndex = .init(utf16Offset: 0, in: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        return Self.init(
            red: Double(r) / 0xff,
            green: Double(g) / 0xff,
            blue: Double(b) / 0xff,
            opacity: 1
        )
    }
}
