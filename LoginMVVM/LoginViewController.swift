//
//  LoginViewController.swift
//  LoginMVVM
//
//  Created by dorenalto mangueira couto on 01/12/24.
//

import UIKit

class LoginViewController: UIViewController {
    private let viewModel = LoginViewModel()

    private let usernameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = AppStrings.usernamePlaceholder.value
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = AppStrings.passwordPlaceholder.value
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppStrings.loginButton.value, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        bindViewModel()

        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }

    private func setupUI() {
        let stack = UIStackView(arrangedSubviews: [usernameField, passwordField])
        stack.axis = .vertical
        stack.spacing = 16
        view.backgroundColor = .blue
        view.addSubview(stack)
        view.addSubview(loginButton)
        constraint(stack)
    }
    
    private func constraint(_ stack: UIStackView) {
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    private func bindViewModel() {
        viewModel.isLoading = { [weak self] isLoading in
            self?.loginButton.isEnabled = !isLoading
            self?.loginButton.setTitle(isLoading ? AppStrings.loadingButton.value : AppStrings.loginButton.value, for: .normal)
        }

        viewModel.onError = { [weak self] error in
            let alert = UIAlertController(
                title: AppStrings.errorTitle.value,
                message: error,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: AppStrings.ok.value, style: .default))
            self?.present(alert, animated: true)
        }

        viewModel.onSuccess = { [weak self] token in
            let message = String(format: AppStrings.successMessage.value, token)
            let alert = UIAlertController(
                title: AppStrings.successTitle.value,
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: AppStrings.ok.value, style: .default))
            self?.present(alert, animated: true)
        }
    }

    @objc private func didTapLogin() {
        let username = usernameField.text ?? String()
        let password = passwordField.text ?? String()
        viewModel.performLogin(username: username, password: password)
    }
}
