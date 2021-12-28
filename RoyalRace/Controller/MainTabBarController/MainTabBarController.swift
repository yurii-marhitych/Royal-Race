//
//  MainTabBarController.swift
//  RoyalRace
//
//  Created by Юра Маргітич on 25.12.2021.
//

import UIKit
import BATabBarController

class MainTabBarController: UIViewController, BATabBarControllerDelegate {
    static let shared = MainTabBarController()

    private lazy var mainTabBarController: BATabBarController = {
        let tabBarController = BATabBarController()
    
        let currentWinnersNavigationController = UINavigationController(rootViewController: CurrentWinnersViewController())
        currentWinnersNavigationController.navigationBar.tintColor = Color.tint
        
        let previousWinnersNavigationController = UINavigationController(rootViewController: PreviousWinnersViewController())
        previousWinnersNavigationController.navigationBar.tintColor = Color.tint
        
        tabBarController.viewControllers = [
            currentWinnersNavigationController,
            previousWinnersNavigationController
        ]
        
        tabBarController.tabBarItems = [
            BATabBarItem(
                image: UIImage(systemName: "star.leadinghalf.filled")!.withTintColor(.systemPink),
                selectedImage: UIImage(systemName: "star.leadinghalf.filled")!,
                title: NSMutableAttributedString(string: "Current Winners", attributes: [
                    .foregroundColor: UIColor.systemGray
                ])
            ),
            
            BATabBarItem(
                image: UIImage(systemName: "calendar")!,
                selectedImage: UIImage(systemName: "calendar")!,
                title: NSMutableAttributedString(string: "Previous Winners", attributes: [
                    .foregroundColor: UIColor.systemGray
                ])
            )
        ]
        
        return tabBarController
    }()

    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainTabBarController()
    }
    
    // MARK: - Setup UI Methods
    private func setupMainTabBarController() {
        mainTabBarController.delegate = self
        self.view.addSubview(mainTabBarController.view)
    }
    
}
