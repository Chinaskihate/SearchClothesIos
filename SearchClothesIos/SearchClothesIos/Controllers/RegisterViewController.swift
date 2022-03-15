//
//  RegisterViewController.swift
//  SearchClothesIos
//
//  Created by user211270 on 3/15/22.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON

class RegisterViewController: UIViewController {
    let backToLoginButton = UIButton()
    let registerLabel = UILabel()
    let emailInput = UITextField()
    let usernameInput = UITextField()
    let passwordInput = UITextField()
    let verificateAccountButton = UIButton()
    let createAccountButton = UIButton()
    let jsonEncoder = JSONEncoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        view.backgroundColor = .systemBlue
        
        setupBackToLoginButton()
        setupKeyboard()
        setupRegisterLabel()
        setupEmailInput()
        setupUsernameInput()
        setupPasswordInput()
        setupVerificateAccountButton()
        setupCreateAccountButton()
        view.backgroundColor = ColorConverter.hexStringToUIColor(hex: "27282D")
    }
    
    private func setupBackToLoginButton() {
        view.addSubview(backToLoginButton)
        
        backToLoginButton.setTitle("Login", for: .normal)
        backToLoginButton.backgroundColor = .clear
        backToLoginButton.setTitleColor(.gray, for: .normal)
        backToLoginButton.frame = CGRect(x: view.frame.width * 0.75, y: view.frame.height * 0.05, width: view.frame.width * 0.2, height: view.frame.height * 0.05)
//        backToLoginButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
//        backToLoginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        backToLoginButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
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
    
    private func setupUsernameInput() {
        view.addSubview(usernameInput)
        usernameInput.backgroundColor = .white
        usernameInput.layer.cornerRadius = 15
        usernameInput.layer.borderWidth = 2
        usernameInput.placeholder = "Enter your username"
        usernameInput.frame = CGRect(x: 100, y: 300, width: 200, height: 52)
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
    
    private func setupRegisterLabel() {
        registerLabel.textAlignment = NSTextAlignment.center
        registerLabel.text = "Register"
        registerLabel.textColor = .white
        registerLabel.layer.cornerRadius = 15
        registerLabel.layer.borderWidth = 2
        registerLabel.font = UIFont(name: registerLabel.font.fontName, size: 40)
        view.addSubview(registerLabel)
        registerLabel.backgroundColor = .clear
        registerLabel.frame = CGRect(x: 100, y: 100, width: 200, height: 52)
    }
    
    private func setupCreateAccountButton() {
        createAccountButton.setTitle("Create Account", for: .normal)
        view.addSubview(createAccountButton)
        createAccountButton.backgroundColor = ColorConverter.hexStringToUIColor(hex: "D0C3BD")
        createAccountButton.setTitleColor(.black, for: .normal)
        createAccountButton.layer.cornerRadius = 15
        createAccountButton.layer.borderWidth = 2
        createAccountButton.frame = CGRect(x: 100, y: 670, width: 200, height: 52)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
    }
    
    private func setupVerificateAccountButton() {
        verificateAccountButton.setTitle("Verificate", for: .normal)
        view.addSubview(verificateAccountButton)
        verificateAccountButton.backgroundColor = ColorConverter.hexStringToUIColor(hex: "D0C3BD")
        verificateAccountButton.setTitleColor(.black, for: .normal)
        verificateAccountButton.layer.cornerRadius = 15
        verificateAccountButton.layer.borderWidth = 2
        verificateAccountButton.frame = CGRect(x: 100, y: 600, width: 200, height: 52)
        verificateAccountButton.addTarget(self, action: #selector(didTapVerificateAccountButton), for: .touchUpInside)
    }
    
    @objc private func didTapVerificateAccountButton() {
        var verificateCommand = VerificateCommandDto()
        verificateCommand.email = emailInput.text
        let ac = UIAlertController(title: "Confirm account", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "Enter verification code"
        }
        let submitAction = UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
            verificateCommand.verificationCode = ac.textFields![0].text
            let jsonRegisterPost = try! self.jsonEncoder.encode(verificateCommand)
            var request = URLRequest(url: URL(string: "http://185.242.104.101/api/user/verificate")!)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonRegisterPost
            self.sendVerificateRequest(data: jsonRegisterPost, request: request)
            if (DataStorage.shared.user != nil) {
                let rootVC = MainViewController()
                rootVC.title = "Login"
                let navVC = UINavigationController(rootViewController: rootVC)
                navVC.modalPresentationStyle = .fullScreen
                navVC.isNavigationBarHidden = true
                self.present(navVC, animated: true)
            }
        })
        ac.addAction(submitAction)
        present(ac, animated: true)
    }

    @objc private func didTapCreateAccountButton() {
        var registerCommand = RegisterCommandDto()
        registerCommand.email = emailInput.text
        registerCommand.username = usernameInput.text
        registerCommand.password = passwordInput.text
        let jsonLoginPost = try! jsonEncoder.encode(registerCommand)
        var request = URLRequest(url: URL(string: "http://185.242.104.101/api/user/register")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonLoginPost
        sendRegisterRequest(data: jsonLoginPost, request: request)
        if (DataStorage.shared.registrationResult == nil) {
            return
        }
        var title = "Error"
        var message = "User already exists"
        if (DataStorage.shared.registrationResult == 0) {
            title = "Success"
            message = "Check your email for verification code"
        }
        var someAlert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        someAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        present(someAlert, animated: true, completion: nil)
        
//        if (DataStorage.shared.isAccountCreated != nil) {
//            let rootVC = MainViewController()
//            rootVC.title = "Login"
//            let navVC = UINavigationController(rootViewController: rootVC)
//            navVC.modalPresentationStyle = .fullScreen
//            navVC.isNavigationBarHidden = true
//            present(navVC, animated: true)
//        }
    }
    
    private func sendRegisterRequest(data: Data, request: URLRequest) {
        let sem = DispatchSemaphore.init(value: 0)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            defer {sem.signal()}
            if let data = data, let registrationResult = try? JSONDecoder().decode(Int.self, from: data) {
                var storage = DataStorage.shared
                storage.registrationResult = registrationResult
            }
        }
        task.resume()
        sem.wait()
    }
    
    private func sendVerificateRequest(data: Data, request: URLRequest) {
        let sem = DispatchSemaphore.init(value: 0)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            defer {sem.signal()}
            if let data = data, let user = try? JSONDecoder().decode(User.self, from: data) {
                var storage = DataStorage.shared
                storage.user = user
            }
        }
        task.resume()
        sem.wait()
    }
}

