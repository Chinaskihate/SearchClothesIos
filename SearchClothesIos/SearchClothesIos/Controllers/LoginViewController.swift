//
//  ViewController.swift
//  SearchClothesIos
//
//  Created by user211270 on 3/13/22.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON

class LoginViewController: UIViewController {
    let loginLabel = UILabel()
    let emailInput = UITextField()
    let passwordInput = UITextField()
    let loginButton = UIButton()
    let registerButton = UIButton()
    let jsonEncoder = JSONEncoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        setupKeyboard()
        setupLoginLabel()
        setupEmailInput()
        setupPasswordInput()
        setupLoginButton()
        setupRegisterButton()
        view.backgroundColor = ColorConverter.hexStringToUIColor(hex: "27282D")
    }
    
    private func setupKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupEmailInput() {
        view.addSubview(emailInput)
        emailInput.backgroundColor = .white
        emailInput.layer.cornerRadius = 15
        emailInput.layer.borderWidth = 2
        emailInput.placeholder = "Enter your email"
        emailInput.frame = CGRect(x: 100, y: 200, width: 200, height: 52)
    }
    
    private func setupPasswordInput() {
        view.addSubview(passwordInput)
        passwordInput.layer.cornerRadius = 15
        passwordInput.layer.borderWidth = 2
        passwordInput.isSecureTextEntry = true
        passwordInput.backgroundColor = .white
        passwordInput.placeholder = "Enter your password"
        passwordInput.frame = CGRect(x: 100, y: 400, width: 200, height: 52)
        
    }
    
    private func setupLoginLabel() {
        loginLabel.textAlignment = NSTextAlignment.center
        loginLabel.text = "Login"
        loginLabel.textColor = .white
        loginLabel.layer.cornerRadius = 15
        loginLabel.layer.borderWidth = 2
        loginLabel.font = UIFont(name: loginLabel.font.fontName, size: 40)
        view.addSubview(loginLabel)
        loginLabel.backgroundColor = .clear
        loginLabel.frame = CGRect(x: 100, y: 100, width: 200, height: 52)
    }
    
    private func setupLoginButton() {
        loginButton.setTitle("Login", for: .normal)
        view.addSubview(loginButton)
        loginButton.backgroundColor = ColorConverter.hexStringToUIColor(hex: "D0C3BD")
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.layer.cornerRadius = 15
        loginButton.layer.borderWidth = 2
        loginButton.frame = CGRect(x: 100, y: 670, width: 200, height: 52)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    private func setupRegisterButton() {
        registerButton.setTitle("Register", for: .normal)
        view.addSubview(registerButton)
        registerButton.backgroundColor = ColorConverter.hexStringToUIColor(hex: "D0C3BD")
        registerButton.setTitleColor(.black, for: .normal)
        registerButton.layer.cornerRadius = 15
        registerButton.layer.borderWidth = 2
        registerButton.frame = CGRect(x: 100, y: 600, width: 200, height: 52)
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }

    @objc private func didTapLoginButton() {
        var loginPost = LoginCommandDto()
        loginPost.email = emailInput.text
        loginPost.password = passwordInput.text
        let jsonLoginPost = try! jsonEncoder.encode(loginPost)
        var request = URLRequest(url: URL(string: "http://185.242.104.101/api/user/login")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonLoginPost
        sendRequest(data: jsonLoginPost, request: request)
        if (DataStorage.shared.user != nil) {
            let rootVC = MainViewController()
            rootVC.title = "Login"
            let navVC = UINavigationController(rootViewController: rootVC)
            navVC.modalPresentationStyle = .fullScreen
            navVC.isNavigationBarHidden = true
            present(navVC, animated: true)
        }
    }
    
    @objc private func didTapRegisterButton() {
        let rootVC = RegisterViewController()
        rootVC.title = "Regitser"
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        navVC.isNavigationBarHidden = true
        present(navVC, animated: true)
        
    }
    
    private func sendRequest(data: Data, request: URLRequest) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let user = try? JSONDecoder().decode(User.self, from: data) {
                var storage = DataStorage.shared
                storage.user = user
            }
        }
        task.resume()
    }
}
