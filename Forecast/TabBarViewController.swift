//
//  TabBarViewController.swift
//  Forecast
//
//  Created by Akezhan Sauirbayev  on 14.04.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationItem.setHidesBackButton(true, animated: false)
        let stockNavigationController = UINavigationController(rootViewController: StockViewController())
        let newsNavigationController = UINavigationController(rootViewController: NewsViewController())
        let forecastNavigationController = UINavigationController(rootViewController: ForecastViewController())
        let profileNavigationController = UINavigationController(rootViewController: ProfileViewController())
        
        stockNavigationController.tabBarItem = UITabBarItem(title: "Stock", image: UIImage(systemName: "arrow.upright.circle"), tag: 1)
        newsNavigationController.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), tag: 2)
        forecastNavigationController.tabBarItem = UITabBarItem(title: "Forecast", image: UIImage(systemName: "dollarsign.arrow.circlepath"), tag: 3)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 4)
        
        
        self.viewControllers = [stockNavigationController, newsNavigationController, forecastNavigationController, profileNavigationController]
        tabBar.backgroundColor = .tabBarColor
        tabBar.tintColor = UIColor.fontGreenColor
        tabBar.unselectedItemTintColor = UIColor(white: 1, alpha: 1)
        NSLayoutConstraint.activate([
            tabBar.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -85),
            tabBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            tabBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    

}

