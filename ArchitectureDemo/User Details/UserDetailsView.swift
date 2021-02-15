//
//  UserDetailsView.swift
//  ArchitectureDemo
//
//  Created by Saurabh Bajaj on 15/02/21.
//

import UIKit

protocol UserDetailsViewDelegate: class {
    func favButtonTapped()
}

class UserDetailsView: UIView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!

    weak var delegate: UserDetailsViewDelegate?

    func setDataSource(dataSource: [String: Any]) {
        if let name = dataSource["name"] as? String {
            nameLabel.text = name
        }

        if let username = dataSource["username"] as? String {
            usernameLabel.text = username
        }

        if let address = dataSource["address"] as? String {
            addressLabel.text = address
        }

        if let company = dataSource["company"] as? String {
            companyNameLabel.text = company
        }

        if let phone = dataSource["phone"] as? String {
            phoneLabel.text = phone
        }

        if let website = dataSource["website"] as? String {
            websiteLabel.text = website
        }

        if let imageName = dataSource["favButtonImage"] as? String {
            let image = UIImage(systemName: imageName)
            favButton.setImage(image, for: .normal)
        }
    }

    // MARK: IBActions
    @IBAction func favButtonTapped(sender: UIButton) {
        delegate?.favButtonTapped()
    }
}
