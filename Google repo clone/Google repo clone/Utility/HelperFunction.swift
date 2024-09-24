import Foundation

struct AppHelper {
    
    static func convertLangColor(lang: String) -> UInt {
        return AppHelper.languageColors[lang] ?? 0xFFB07219;
    }
    
    static let languageColors: [String: UInt] = [
        "Java": 0xFFB07219,
        "Swift": 0xFFFFAC45,
        "Python": 0xFF3572A5,
        "JavaScript": 0xFFF1E05A,
        "C#": 0xFF178600,
        "C++": 0xFFF34B7D,
        "Ruby": 0xFF701516,
        "Go": 0xFF00ADD8,
        "HTML": 0xFFE34C26,
        "CSS": 0xFF563D7C,
        "TypeScript": 0xFF2B7489,
        "Kotlin": 0xFFA97BFF,
        "PHP": 0xFF4F5D95,
    ]
    
}
