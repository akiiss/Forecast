import UIKit

class LoginViewController: UIViewController {
    let labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "Stock", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 64),
            NSAttributedString.Key.foregroundColor: UIColor.fontGreenColor
        ])
        
        return label
    }()
    
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("login", for: .normal)
        button.backgroundColor = .fontGreenColor
        button.addTarget(nil, action: #selector(goToMainPage), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 25
        
        return button
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
            string: "Username or email",
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
    
    let accountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "Do not you have an account?", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.buttonColor
        ])
        return label
    }()
    let signupButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign up", for: .normal)
        button.addTarget(nil, action: #selector(goToSignUp), for: .touchUpInside)
        button.backgroundColor = UIColor.init(white: 1, alpha: 0.9)
        button.setTitleColor(.buttonColor, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 20
        
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        view.gradientBackground(colors: [UIColor(red: 0.0, green: 75/255, blue: 49/255, alpha: 1.0), UIColor(red: 17/255, green: 23/255, blue: 21/255, alpha: 1.0)])
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(loginButton)
        view.addSubview(labelTitle)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(accountLabel)
        view.addSubview(signupButton)
        self.tabBarController?.tabBar.isHidden = true
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailField.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 150),
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 25),
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 70),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            accountLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 150),
            accountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupButton.topAnchor.constraint(equalTo: accountLabel.bottomAnchor, constant: 15),
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    
    @objc func goToMainPage(_ sender: UIButton) {
        if (emailField.text ?? "").isEmpty {
            return
        }
        
        if (passwordField.text ?? "").isEmpty {
            return
        }
        
        let pass = passwordField.text?.lowercased()
        let email = emailField.text?.lowercased()
        
        if email! != admin.username || pass! != admin.password {
            return
        }
        
        let vc = TabBarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func goToSignUp(_ sender: UIButton) {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
