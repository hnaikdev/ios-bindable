//
//  LockViewController.swift
//  BindableExample
//
//  Created by Hiral Naik on 1/6/26.
//

import UIKit
import ios_bindable

import UIKit

final class LockViewController: UIViewController {

    private let viewModel = LockViewModel()

    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let errorLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bindViewModel()
    }

    private func bindViewModel() {

        viewModel.isLoginEnabled.bindAndFire { [weak self] enabled in
            DispatchQueue.main.async {
                self?.loginButton.isEnabled = enabled ?? false
            }
        }

        viewModel.isLoading.bind { [weak self] loading in
            DispatchQueue.main.async {
                loading == true
                    ? self?.activityIndicator.startAnimating()
                    : self?.activityIndicator.stopAnimating()
            }
        }

        viewModel.errorMessage.bind { [weak self] message in
            DispatchQueue.main.async {
                self?.errorLabel.text = message
                self?.errorLabel.isHidden = message == nil
            }
        }
    }

    private func setupUI() {
        usernameField.placeholder = "Username"
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true

        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)

        errorLabel.textColor = .red
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true

        let stack = UIStackView(arrangedSubviews: [
            usernameField,
            passwordField,
            loginButton,
            activityIndicator,
            errorLabel
        ])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        usernameField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    @objc private func textDidChange() {
        viewModel.username.value = usernameField.text
        viewModel.password.value = passwordField.text
    }

    @objc private func didTapLogin() {
        viewModel.login()
    }
}
