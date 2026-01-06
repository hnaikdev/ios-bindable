//
//  QueueViewController.swift
//  BindableExample
//
//  Created by Hiral Naik on 1/6/26.
//

import UIKit
import ios_bindable

final class QueueViewController: UIViewController {

    private let viewModel = QueueViewModel()

    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let errorLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bindViewModel()
        viewModel.loadUsers()
    }

    private func bindViewModel() {

        viewModel.title.bindAndFire { [weak self] title in
            DispatchQueue.main.async {
                self?.navigationItem.title = title
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

        viewModel.users.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func setupUI() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        errorLabel.textColor = .red
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.addSubview(errorLabel)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension QueueViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if let user = viewModel.user(at: indexPath.row) {
            cell.textLabel?.text = user.name
        }

        return cell
    }
}

