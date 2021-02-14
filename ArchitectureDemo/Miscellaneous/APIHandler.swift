//
//  APIHandler.swift
//  ArchitectureDemo
//
//  Created by Saurabh Bajaj on 14/02/21.
//  Copyright © 2021 ArchitectureDemo. All rights reserved.
//

import UIKit
import Alamofire

// TODO: uncomment hideLoading commands when touch blocker is implemented
// TODO: replace print error commands with a logger command

typealias responseHandler = (Int, Any?) -> Void

class APIHandler: NSObject, URLSessionDelegate {

    static let timeoutInterval: TimeInterval = 30

    class func request(urlString: String,
                 method: HTTPMethod,
                 params: [String: Any]?,
                 showLoader: Bool = true,
                 completion: @escaping responseHandler) {
        guard InternetConnection.isConnectedToNetwork() else {
            AppManager.shared.hideLoading()
            showAlertMessage("Check your network connection", viewController: nil)
            return
        }
        var urlComponents = URLComponents(string: urlString)
        if method == HTTPMethod.get && params != nil {
            var queryItems = [URLQueryItem]()
            for (key, value) in params! {
                if value is [Any] {
                    for item in value as! [String] {
                        queryItems.append(URLQueryItem(name: key, value: item))
                    }
                    continue
                }
                queryItems.append(URLQueryItem(name: key, value: value as? String))
            }
            urlComponents?.queryItems = queryItems
        }
        if showLoader { AppManager.shared.showLoading() }
        guard let url = urlComponents?.url else {
            AppManager.shared.hideLoading()
            return
        }
        AF.request(url, method: method, parameters: params).responseJSON { response in
            AppManager.shared.hideLoading()
            if let statusCode = response.response?.statusCode {
                switch statusCode {
                case 200...300:
//                    if let json = response.result/*.value*/ {
                    completion(statusCode, response.data)
//                    }
                case 400...499:
                    var errorMessage = "Bad Request"
                    if let message = response.error?.errorDescription, !message.isEmpty {
                        errorMessage = message
                    }
                    showAlertMessage(errorMessage, viewController: nil)
                    completion(statusCode, nil)

                default:
                    var errorMessage = "Something went wrong!!"
                    if let message = response.error?.errorDescription, !message.isEmpty {
                        errorMessage = message
                    }
                    showAlertMessage(errorMessage, viewController: nil)
                    completion(statusCode, nil)
                }
            } else {
                // Common error message
                #if DEBUG
                print(response.response?.url as Any)
                #endif
                showAlertMessage("Something went wrong!!", viewController: nil)
            }
        }
    }
}
