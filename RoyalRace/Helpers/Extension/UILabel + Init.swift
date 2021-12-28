//
//  UILabel + Init.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 27.12.2021.
//

import UIKit

// MARK: - Initializers
extension UILabel {
    convenience init(withText text: String, ofSize size: CGFloat = 18, style: FontStyle = .regular) {
        self.init(frame: .zero)
        
        self.text = text
        font = UIFont(name: "Avenir Next \(style.rawValue)", size: size)
        textColor = .white
        textAlignment = .left
        numberOfLines = 1
        minimumScaleFactor = 0.5
    }
    
    enum FontStyle: String {
        case bold = "Bold"
        case demiBold = "Demo Bold"
        case heavy = "Heavy"
        case medium = "Medium"
        case regular = "Regular"
        case ultraLight = "Ultra Light"
    }
}
