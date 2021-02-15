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

    var selectedIndex: Int?

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

    /// Returns user details in presentable form for the user passed in parameter.
    func userDetailsPresentable(user: User) -> [String: Any] {
        var dict = [String: Any]()
        dict["name"] = user.name.capitalized
        dict["username"] = user.username
        dict["address"] = "\(user.address.street.capitalized), \(user.address.suite.capitalized), \(user.address.city.capitalized), \(user.address.zipcode)"
        dict["company"] = user.company.name.capitalized
        dict["phone"] = user.phone
        dict["website"] = user.website
        let isFav = user.isFav ?? false
        var imageName = "star"
        if isFav {
            imageName = "star.fill"
        }
        dict["favButtonImage"] = imageName
        return dict
    }

    func udpateUser(user: User, index: Int) {
        users[index] = user
    }
}
