//
//  UsersViewController.swift
//  Restaurants
//
//  Created by Svyatoslav Katola on 26.01.2021.
//

import UIKit

class UsersViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    
    let cellID = "cell"

    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadItems(handler: updateView(error:))
    }
    
    func updateView(error: Error?) {
        if let err = error {
            createAlert(title: "Error", message: err.localizedDescription)
        } else {
            tableView.reloadData()
        }
    }
    
    var viewModel = UsersViewModel(usersService: assembly.services.service(UserService.self))
}

// MARK: - Table View

extension UsersViewController: UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EditUserViewController.instantiate()
        vc.user = viewModel.items[indexPath.row]
        vc.userService = assembly.services.service(UserService.self)
        present(vc, animated: true) {
            self.viewModel.loadItems(handler: self.updateView(error:))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let item = viewModel.items[indexPath.row]
        cell.textLabel?.text = item.email
        cell.detailTextLabel?.text = item.isManager ? "Manges: \(item.restaurants) restoraunts." : "Not a Manager"
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
