//
//  SignUpViewController.swift
//  Final
//
//  Created by Akezhan Sauirbayev  on 19.12.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "Stock", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 64),
            NSAttributedString.Key.foregroundColor: UIColor.fontGreenColor
        ])
        return label
    }()
    
    
    let usernameField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textAlignment = .center
        field.textColor = .white
        field.borderStyle = .roundedRect
        field.layer.cornerRadius = 25
        field.clipsToBounds = true
        field.attributedPlaceholder = NSAttributedString (
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.2)])
        field.backgroundColor = UIColor(red: 13/255, green: 39/255, blue: 30/255, alpha: 1.0)
        field.autocapitalizationType = .none
        field.layer.borderWidth = 2.0
        field.layer.borderColor = UIColor.fontGreenColor.cgColor
        NSLayoutConstraint.activate([
            field.widthAnchor.constraint(equalToConstant: 260),
            field.heightAnchor.constraint(equalToConstant: 50),
        ])
        return field
    }()
    
    
    let emailField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textAlignment = .center
        field.textColor = .white
        field.borderStyle = .roundedRect
        field.layer.cornerRadius = 25
        field.clipsToBounds = true
        field.attributedPlaceholder = NSAttributedString (
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.2)])
        field.backgroundColor = UIColor(red: 13/255, green: 39/255, blue: 30/255, alpha: 1.0)
        field.autocapitalizationType = .none
        field.layer.borderWidth = 2.0
        field.layer.borderColor = UIColor.fontGreenColor.cgColor
        NSLayoutConstraint.activate([
            field.widthAnchor.constraint(equalToConstant: 260),
            field.heightAnchor.constraint(equalToConstant: 50),
        ])
        return field
    }()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textAlignment = .center
        field.textColor = .white
        field.borderStyle = .roundedRect
        field.autocapitalizationType = .none
        field.layer.cornerRadius = 25
        field.clipsToBounds = true
        field.attributedPlaceholder = NSAttributedString (
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.2)])
        field.backgroundColor = UIColor(red: 13/255, green: 39/255, blue: 30/255, alpha: 1.0)
        field.isSecureTextEntry = true
        field.layer.borderWidth = 2.0
        field.layer.borderColor = UIColor.fontGreenColor.cgColor
        NSLayoutConstraint.activate([
            field.widthAnchor.constraint(equalToConstant: 260),
            field.heightAnchor.constraint(equalToConstant: 50),
        ])
        return field
    }()
    
    let signupButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(.fontGreenColor, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 25
        
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        view.gradientBackground(colors: [UIColor(red: 0.0, green: 75/255, blue: 49/255, alpha: 1.0), UIColor(red: 17/255, green: 23/255, blue: 21/255, alpha: 1.0)])
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
//        self.title = "Stock"
//        navigationController?.setNavigationBarHidden(true, animated: false)
//        navigationItem.backButtonDisplayMode = .minimal
//        navigationItem.backButtonTitle = ""
        navigationItem.setHidesBackButton(true, animated: false)
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(labelTitle)
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signupButton)
        
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameField.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 150),
            usernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 25),
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 25),
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 70),
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    
    

}
