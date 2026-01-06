//
//  BindableTableViewController.swift
//  BindableExample
//
//  Created by Hiral Naik on 1/6/26.
//

import UIKit

class BindableTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BindableTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = cell.defaultContentConfiguration()
        if indexPath.row == 0 {
            config.text = "Bindable"
        } else if indexPath.row == 1 {
            config.text = "Lock Bindable"
        } else {
            config.text = "Queue Bindable"
        }
        cell.contentConfiguration = config
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let viewController = ViewController()
            navigationController?.pushViewController(viewController, animated: true)
        } else if indexPath.row == 1 {
            let viewController = LockViewController()
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            
        }
    }
}
