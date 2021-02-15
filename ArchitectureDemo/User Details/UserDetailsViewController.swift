//
//  UserDetailsViewController.swift
//  ArchitectureDemo
//
//  Created by Saurabh Bajaj on 14/02/21.
//

import UIKit

class UserDetailsViewController: UIViewController {

    /// Holds information of the user whose details have to be displayed
    var user: User!

    @IBOutlet var userDetailsView: UserDetailsView!

    private var viewModel: UserDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewModel = UserDetailsViewModel(user: self.user)
        self.viewModel.delegate = self
        userDetailsView.delegate = self
        showUserDetails()
    }
    
    func showUserDetails() {
        self.userDetailsView.setDataSource(dataSource: viewModel.userDetailsPresentable())
    }
}


extension UserDetailsViewController: UserDetailsViewModelDelegate {
    func didUpdateModel() {
        showUserDetails()
    }
}


extension UserDetailsViewController: UserDetailsViewDelegate {
    func favButtonTapped() {
        // update view model
        self.viewModel.toggleFavourite()
    }
}
