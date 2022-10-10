//
//  TabBarViewController.swift
//  Countries
//
//  Created by Bengi Tunca on 10.10.2022.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar(){
        tabBar.items![0].title = GlobalVariables.tabBarItemName1
        tabBar.items![1].title = GlobalVariables.tabBarItemName2
    }
}
