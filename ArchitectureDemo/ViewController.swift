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
        viewModel.delegate = self
        viewModel.getUsersList()
    }
}

extension ViewController: UserListViewModelDelegate {
    func didUpdateModel() {
        // update tableview
        updateDataSource()
    }

    func updateDataSource() {
        self.dataSource = UserListDataSource(cellIdentifier: "userListCell", items: self.viewModel.users, configureCell: { (cell, user) in
            cell.setDataSource(dataSource: user)
        })

        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
}
