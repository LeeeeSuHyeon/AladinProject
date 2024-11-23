//
//  TabBarController.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    private let homeVC = UINavigationController(rootViewController: HomeViewController())
    private let favoriteVC = UINavigationController(rootViewController: FavoriteViewController())

    private let myPageVC = MyPageViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        self.tabBar.tintColor = .black
        self.tabBar.isTranslucent = false
        homeVC.isNavigationBarHidden = true
        setTabBarItem()
        
    }
    
    private func setTabBarItem(){
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: .init(systemName: "house"), tag: 0)
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorite", image: .init(systemName: "heart"), tag: 1)
        myPageVC.tabBarItem = UITabBarItem(title: "My", image: .init(systemName: "person"), tag: 2)
        
        self.viewControllers = [homeVC, favoriteVC, myPageVC]
    }
}
