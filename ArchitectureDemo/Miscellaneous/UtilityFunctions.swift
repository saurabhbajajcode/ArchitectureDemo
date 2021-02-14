//
//  UtilityFunctions.swift
//  ArchitectureDemo
//
//  Created by Saurabh Bajaj on 14/02/21.
//

import UIKit

func showAlertMessage(_ string: String, viewController: UIViewController?) {
    let alert = UIAlertController(title: "", message: string, preferredStyle: .alert)
    let dismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
    alert.addAction(dismiss)
    if viewController != nil {
        viewController!.present(alert, animated: true, completion: nil)
    } else {
        DispatchQueue.main.async {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            (keyWindow?.rootViewController)?.present(alert, animated: true, completion: nil)
        }
    }
}
