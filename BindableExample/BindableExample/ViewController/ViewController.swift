//
//  ViewController.swift
//  BindableExample
//
//  Created by Hiral Naik on 1/6/26.
//

import UIKit
import ios_bindable

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()

    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Increment", for: .normal)
        return button
    }()
    
    private let button1: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Decrement", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.title.bindAndFire { [weak self] title in
            self?.titleLabel.text = title
        }

        viewModel.count.bindAndFire { [weak self] count in
            self?.countLabel.text = "Count: \(count ?? 0)"
        }

        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button1.addTarget(self, action: #selector(didTapButton1), for: .touchUpInside)
    }

    @objc private func didTapButton() {
        viewModel.update(isIncrement: true)
    }
    
    @objc private func didTapButton1() {
        viewModel.update(isIncrement: false)
    }

    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            countLabel,
            button,
            button1
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
