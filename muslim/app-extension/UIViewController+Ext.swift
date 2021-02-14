//
//  UIViewController+Ext.swift
//  muslim
//
//  Created by Rangga Leo on 15/01/21.
//

import UIKit

extension UIViewController {
    
    public func showAlert(title: String?, message: String? = nil, OKCompletion: ((UIAlertAction) -> Void)? = nil) {
        let alertController             = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.tintColor  = UIMColor.brandColor()
        
        alertController.addAction(UIAlertAction(title: LButton.ok.localized, style: .default, handler: OKCompletion))
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func showAlertConfirm(title: String?, message: String? = nil, OKCompletion: ((UIAlertAction) -> Void)? = nil, CancelCompletion: ((UIAlertAction) -> Void)? = nil) {
        let alert               = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor    = UIMColor.brandColor()
        alert.addAction(UIAlertAction(title: LButton.ok.localized, style: .default, handler: OKCompletion))
        alert.addAction(UIAlertAction(title: LButton.cancel.localized, style: .cancel, handler: CancelCompletion))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoaderIndicator() {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.keyWindow {
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
        DispatchQueue.main.async {
            if let window = UIApplication.shared.keyWindow {
                window.subviews.compactMap { $0 as? UIActivityIndicatorView }.forEach {
                    $0.backgroundColor = .clear
                    $0.removeFromSuperview()
                }
            }
        }
    }
}
