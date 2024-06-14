//
//  ProfileViewController.swift
//  Forecast
//
//  Created by Akezhan Sauirbayev  on 14.04.2024.
//

import Foundation
import UIKit


class ProfileViewController: UIViewController {
    let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("logout", for: .normal)
        button.addTarget(nil, action: #selector(logout), for: .touchUpInside)
        button.backgroundColor = .fontGreenColor
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.gradientBackground(colors: [UIColor(red: 0.0, green: 75/255, blue: 49/255, alpha: 1.0), UIColor(red: 17/255, green: 23/255, blue: 21/255, alpha: 1.0)])
        setupUI()
    
        
        
        
        navigationController?.setNavigationBarHidden(true, animated: false)
            
            // Create a custom navigation view
            let customNavBar = UIView()
            customNavBar.backgroundColor = .clear
            view.addSubview(customNavBar)
            
            // Setup constraints or frame for the custom navigation bar
            customNavBar.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                customNavBar.leftAnchor.constraint(equalTo: view.leftAnchor),
                customNavBar.rightAnchor.constraint(equalTo: view.rightAnchor),
                customNavBar.topAnchor.constraint(equalTo: view.topAnchor),
                customNavBar.heightAnchor.constraint(equalToConstant: 120) // Set your custom height
            ])
        
        let titleLabel = UILabel()
            titleLabel.text = "Profile"
            titleLabel.textColor = .buttonColor
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            
            // Add the title label to the custom navigation bar
            customNavBar.addSubview(titleLabel)
            
            // Setup constraints for the title label
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.centerXAnchor.constraint(equalTo: customNavBar.centerXAnchor),
                titleLabel.topAnchor.constraint(equalTo: customNavBar.topAnchor, constant: 70)
            ])
    }
    
    
    private func setupUI(){
        
        view.addSubview(logoutButton)
        
        
        NSLayoutConstraint.activate([
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    
    @objc func logout() {
        let loginViewController = LoginViewController()
        
        navigationController?.setViewControllers([loginViewController], animated: true)
    }
    
    
}

