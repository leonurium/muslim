//
//  AppLifecycleMediator.swift
//  muslim
//
//  Created by Rangga Leo on 13/12/20.
//

import Foundation
import UIKit

protocol AppLifecycleListener: class {
    func willResignActive()
    func didEnterBackground()
    func willEnterForeground()
}

//extension AppLifecycleListener {
//    func willResignActive() {
//        self.willResignActive()
//    }
//    
//    func didEnterBackground() {
//        self.didEnterBackground()
//    }
//    
//    func willEnterForeground() {
//        self.willEnterForeground()
//    }
//}

class AppLifecycleMediator: NSObject {
    private var listeners: [AppLifecycleListener] = []
    
    init(listeners: [AppLifecycleListener]) {
        self.listeners.append(contentsOf: listeners)
        super.init()
        subscribe()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func subscribe() {        
        if #available(iOS 13.0, *) {
            NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIScene.willDeactivateNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIScene.didEnterBackgroundNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIScene.willEnterForegroundNotification, object: nil)
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        }
    }
    
    @objc private func willResignActive() {
        listeners.forEach({ $0.willResignActive() })
    }
    
    @objc private func didEnterBackground() {
        listeners.forEach({ $0.didEnterBackground() })
    }
    
    @objc private func willEnterForeground() {
        listeners.forEach({ $0.willEnterForeground() })
    }
}
