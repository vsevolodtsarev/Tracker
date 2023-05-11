//
//  Colors.swift
//  Tracker
//
//  Created by Всеволод Царев on 30.04.2023.
//

import Foundation
import UIKit

final class UIColorMarshalling {
    func hexString(from color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        return String.init(
            format: "%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )
    }

    func color(from hex: String) -> UIColor {
        var rgbValue:UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UIColor {
    static let color1 = UIColor(named: "Color selection 1") ?? UIColor.clear
    static let color2 = UIColor(named: "Color selection 2") ?? UIColor.clear
    static let color3 = UIColor(named: "Color selection 3") ?? UIColor.clear
    static let color4 = UIColor(named: "Color selection 4") ?? UIColor.clear
    static let color5 = UIColor(named: "Color selection 5") ?? UIColor.clear
    static let color6 = UIColor(named: "Color selection 6") ?? UIColor.clear
    static let color7 = UIColor(named: "Color selection 7") ?? UIColor.clear
    static let color8 = UIColor(named: "Color selection 8") ?? UIColor.clear
    static let color9 = UIColor(named: "Color selection 9") ?? UIColor.clear
    static let color10 = UIColor(named: "Color selection 10") ?? UIColor.clear
    static let color11 = UIColor(named: "Color selection 11") ?? UIColor.clear
    static let color12 = UIColor(named: "Color selection 12") ?? UIColor.clear
    static let color13 = UIColor(named: "Color selection 13") ?? UIColor.clear
    static let color14 = UIColor(named: "Color selection 14") ?? UIColor.clear
    static let color15 = UIColor(named: "Color selection 15") ?? UIColor.clear
    static let color16 = UIColor(named: "Color selection 16") ?? UIColor.clear
    static let color17 = UIColor(named: "Color selection 17") ?? UIColor.clear
    static let color18 = UIColor(named: "Color selection 18") ?? UIColor.clear
    static let emojiBackground = UIColor(named: "emojiBackground") ?? UIColor.clear
}

