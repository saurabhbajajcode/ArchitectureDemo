//
//  UserListViewModel.swift
//  ArchitectureDemo
//
//  Created by Saurabh Bajaj on 14/02/21.
//

import Foundation

class UserListViewModel: NSObject {

    private(set) var users: [User]?
}

func getUsersList() {
    let urlString = "https://jsonplaceholder.typicode.com/users"
    APIHandler.request(urlString: urlString, method: .get, params: nil) { (statusCode, response) in
        switch statusCode {
        case 200...299:
            if let data = response as? Data {
                let users = try? JSONDecoder().decode([User].self, from: data)
                print(users!)
            }

        default:
            // can perform some action, if needed.
            break
        }

    }
}
