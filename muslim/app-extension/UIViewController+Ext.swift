//
//  UIViewController+Ext.swift
//  muslim
//
//  Created by Rangga Leo on 15/01/21.
//

import UIKit

extension UIViewController {
    func showLoaderIndicator() {
        if let window = UIApplication.shared.keyWindow {
            DispatchQueue.main.async {
                let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
                activityIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                activityIndicator.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
                activityIndicator.startAnimating()
                
                window.addSubview(activityIndicator)
                activityIndicator.center = window.center
            }
        }
    }
    
    func dismissLoaderIndicator() {
        if let window = UIApplication.shared.keyWindow {
            DispatchQueue.main.async {
                window.subviews.compactMap { $0 as? UIActivityIndicatorView }.forEach {
                    $0.backgroundColor = .clear
                    $0.removeFromSuperview()
                }
            }
        }
    }
}
