//
//  UserListViewModel.swift
//  ArchitectureDemo
//
//  Created by Saurabh Bajaj on 14/02/21.
//

import Foundation

protocol UserListViewModelDelegate {
    func didUpdateModel()
}

class UserListViewModel: NSObject {

    private(set) var users: [User]! {
        didSet {
            // inform controller
            delegate?.didUpdateModel()
        }
    }

    var delegate: UserListViewModelDelegate?

    // This will contain info about the user selected by the user.
    var selectedUser: User?

    func getUsersList() {
        let urlString = "https://jsonplaceholder.typicode.com/users"
        APIHandler.request(urlString: urlString, method: .get, params: nil) { (statusCode, response) in
            switch statusCode {
            case 200...299:
                if let data = response as? Data {
                    let users = try? JSONDecoder().decode([User].self, from: data)
                    self.users = users
                }

            default:
                // can perform some action, if needed.
                break
            }

        }
    }

    func detailsViewModel(for user: User) -> UserDetailsViewModel {
        return UserDetailsViewModel(user: user)
    }
}
