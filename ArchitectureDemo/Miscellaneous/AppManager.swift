//
//  AppManager.swift
//  ArchitectureDemo
//
//  Created by Saurabh Bajaj on 13/02/21.
//

import UIKit

class AppManager: NSObject {

    private static var _sharedInstance = AppManager()
    static var shared: AppManager {
        return AppManager._sharedInstance
    }

    private var touchBlocker: TouchBlocker?

    private override init() {
        super.init()
    }

    /// Reinstantiates AppManager object.
    func resetAppManager() {
        AppManager._sharedInstance = AppManager()
    }

    fileprivate func setupTouchBlocker() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        touchBlocker = TouchBlocker(frame: CGRect.zero)
        touchBlocker?.translatesAutoresizingMaskIntoConstraints = false
        appDelegate?.window?.addSubview(touchBlocker!)
        appDelegate?.window?.addConstraint(NSLayoutConstraint(item: touchBlocker!, attribute: .top, relatedBy: .equal, toItem: appDelegate?.window, attribute: .top, multiplier: 1, constant: 0))
        appDelegate?.window?.addConstraint(NSLayoutConstraint(item: touchBlocker!, attribute: .left, relatedBy: .equal, toItem: appDelegate?.window, attribute: .left, multiplier: 1, constant: 0))
        appDelegate?.window?.addConstraint(NSLayoutConstraint(item: touchBlocker!, attribute: .right, relatedBy: .equal, toItem: appDelegate?.window, attribute: .right, multiplier: 1, constant: 0))
        appDelegate?.window?.addConstraint(NSLayoutConstraint(item: touchBlocker!, attribute: .bottom, relatedBy: .equal, toItem: appDelegate?.window, attribute: .bottom, multiplier: 1, constant: 0))
    }

    func showLoading() {
        DispatchQueue.main.async { [self] in
            guard touchBlocker != nil else {
                setupTouchBlocker()
                showLoading()
                return
            }
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.bringSubviewToFront(self.touchBlocker!)
            touchBlocker!.showLoading()
        }
    }

    func hideLoading() {
        touchBlocker?.hideLoading()
    }
}
