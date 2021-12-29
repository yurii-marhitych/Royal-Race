//
//  UIViewController + setupBackButton.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 26.12.2021.
//

import UIKit
import IHProgressHUD

extension UIViewController {
    func setupBackButton() {
        let backBarButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.done, target: self, action: #selector(popViewController))
        backBarButton.image = UIImage(systemName: "chevron.left")?.withTintColor(Color.tint)
        backBarButton.title = "Back"
        navigationItem.leftBarButtonItem = backBarButton
    }
    
    // MARK: - Helper Methods
    @objc private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
