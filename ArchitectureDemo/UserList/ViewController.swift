//
//  ViewController.swift
//  ArchitectureDemo
//
//  Created by Saurabh Bajaj on 13/02/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let viewModel = UserListViewModel()
    private var dataSource : UserListDataSource<UserListTableViewCell, User>!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        tableView.dataSource = dataSource
        tableView.delegate = self
        viewModel.delegate = self
        viewModel.getUsersList()
    }

    // MARK: Helpers
    fileprivate func navigateToUserDetails(user: User) {
        performSegue(withIdentifier: "showUserDetailsSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserDetailsSegue" {
            let destinationController = segue.destination as! UserDetailsViewController
            destinationController.user = viewModel.selectedUser
            destinationController.delegate = self
        }
    }
}


extension ViewController: UserListViewModelDelegate {
    func didUpdateModel() {
        // update tableview
        updateDataSource()
    }

    func updateDataSource() {
        self.dataSource = UserListDataSource(cellIdentifier: "userListCell", items: self.viewModel.users, configureCell: { (cell, user) in
            let dataSource = self.viewModel.userDetailsPresentable(user: user)
            cell.setDataSource(dataSource: dataSource)
        })

        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.users.endIndex > indexPath.row else { return }
        // navigate to user details view
        let user = viewModel.users[indexPath.row]
        viewModel.selectedUser = user
        viewModel.selectedIndex = indexPath.row
        navigateToUserDetails(user: user)
    }
}


extension ViewController: UserDetailsDelegate {
    func didUpdateUserDetails(user: User) {
        if let index = viewModel.selectedIndex {
            self.viewModel.udpateUser(user: user, index: index)
        }
    }
}
