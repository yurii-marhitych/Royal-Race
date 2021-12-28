//
//  UIViewController + ProgressHUD.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 26.12.2021.
//

import UIKit
import IHProgressHUD

extension UIViewController {
    func showProgressHUD(withStatus status: String? = nil) {
        IHProgressHUD.set(backgroundColor: .black.withAlphaComponent(0.3))
        IHProgressHUD.set(foregroundColor: .white)
        IHProgressHUD.set(borderColor: .white)
        IHProgressHUD.set(borderWidth: 2.0)
        IHProgressHUD.show(withStatus: status)
        
        // block user's interaction with UI
        MainTabBarController.shared.view.isUserInteractionEnabled = false
    }
    
    func dismissProgressHUD() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            IHProgressHUD.dismiss()
        }
        MainTabBarController.shared.view.isUserInteractionEnabled = true
    }
}
