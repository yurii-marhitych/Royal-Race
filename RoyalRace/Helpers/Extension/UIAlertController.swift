//
//  UIAlertController.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 11.01.2022.
//

import UIKit

// MARK: - UIAlertController
extension UIAlertController {
    func setBackgroundColor(color: UIColor?) {
        if let backgroundView = self.view.subviews.first,
           let groupView = backgroundView.subviews.first,
           let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
    
    func setTitle(color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)
        
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor], range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")
    }
    
    func setMessage(color: UIColor?) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)
        
        if let messageColorColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : messageColorColor], range: NSMakeRange(0, message.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedMessage")
    }
    
    func setTint(color: UIColor) {
        self.view.tintColor = color
    }
}
