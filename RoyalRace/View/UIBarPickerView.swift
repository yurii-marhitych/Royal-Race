//
//  UIBarPickerView.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 28.12.2021.
//

import UIKit
import iOSDropDown

class UIBarPickerView: DropDown {

    // MARK: - Initializers
    init(width: CGFloat, height: CGFloat, placeholder: String = "") {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.placeholder = placeholder
        
        cornerRadius = 5
        arrowColor = Color.tint
        rowBackgroundColor = Color.background
        selectedRowColor = .white.withAlphaComponent(0.05)
        isSearchEnable = false
        checkMarkEnabled = false
        textAlignment = .center
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

