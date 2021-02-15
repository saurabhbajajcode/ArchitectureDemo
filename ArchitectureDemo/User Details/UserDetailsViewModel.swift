//
//  UserDetailsViewModel.swift
//  ArchitectureDemo
//
//  Created by Saurabh Bajaj on 14/02/21.
//

import UIKit

protocol UserDetailsViewModelDelegate {
    func didUpdateModel()
}

class UserDetailsViewModel: NSObject {

    private var user: User! {
        didSet {
            // inform controller
            delegate?.didUpdateModel()
        }
    }

    var delegate: UserDetailsViewModelDelegate?

    init(user: User) {
        self.user = user
    }

    /// Returns user details in presentable form.
    func userDetailsPresentable() -> [String: Any] {
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

    func toggleFavourite() {
        user.isFav = !(user.isFav ?? false)
    }
}
