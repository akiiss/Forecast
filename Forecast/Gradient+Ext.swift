//
//  Gradient+Ext.swift
//  Forecast
//
//  Created by Akezhan Sauirbayev  on 14.04.2024.
//

import Foundation
import UIKit


// gradient background
extension UIView {
    func gradientBackground(colors: [UIColor], locations: [NSNumber] = [0.0, 1.0]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)  // Vertical gradient
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        if let oldLayer = (layer.sublayers?.compactMap { $0 as? CAGradientLayer })?.first {
            oldLayer.removeFromSuperlayer()
        }

        layer.insertSublayer(gradientLayer, at: 0)
    }
}

// colors for tabbar
extension UIColor {
    static let fontGreenColor = UIColor(red: 0, green: 208/255, blue: 128/255, alpha: 1.0)
    static let tabBarColor = UIColor(red: 6/255, green: 68/255, blue: 47/255, alpha: 1.0)
    static let buttonColor = UIColor(red: 0.0, green: 202/255, blue: 128/255, alpha: 1.0)
}

//hide keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
