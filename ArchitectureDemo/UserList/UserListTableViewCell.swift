//
//  UserListTableViewCell.swift
//  ArchitectureDemo
//
//  Created by Saurabh Bajaj on 14/02/21.
//

import UIKit

protocol UserListTableViewCellDelegate: class {
    func favButtonTapped(tag: Int)
}

class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!

    weak var delegate: UserListTableViewCellDelegate?

    @IBAction func favButtonTapped(sender: UIButton) {
        delegate?.favButtonTapped(tag: self.tag)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setDataSource(dataSource: [String: Any]) {
        if let name = dataSource["name"] as? String {
            nameLabel.text = name
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
}
