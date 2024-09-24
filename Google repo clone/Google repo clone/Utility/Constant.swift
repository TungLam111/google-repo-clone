import Foundation
import SwiftUI


struct ColorConstants {
    static let cFFFFFFFF = Color(hex: 0xFFFFFF);
}

struct StringConstants {

}

struct NumberConstants {

}

struct FontConstants {
   static let defautFont = "Kodchasan";
}

struct StyleConstant {
}

struct TextStyle {
    let weight: Font.Weight
    let font: Font
    
    init(weight: Font.Weight, fontSize: Int) {
        self.font = Font.custom(FontConstants.defautFont, size: CGFloat(fontSize))
        self.weight = weight
    }
}

