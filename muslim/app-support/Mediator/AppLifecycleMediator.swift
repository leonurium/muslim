//
//  AppLifecycleMediator.swift
//  muslim
//
//  Created by Rangga Leo on 13/12/20.
//

import Foundation

protocol AppLifecycleListener {
    func willResignActive()
    func didEnterBackground()
    func willEnterForeground()
}

extension AppLifecycleListener {
    func willResignActive() {
        self.willResignActive()
    }
    
    func didEnterBackground() {
        self.didEnterBackground()
    }
    
    func willEnterForeground() {
        self.willEnterForeground()
    }
}

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
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: .willResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: .didEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: .willEnterForeground, object: nil)
    }
    
    static func push(name: NSNotification.Name) {
        NotificationCenter.default.post(name: name, object: nil, userInfo: nil)
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
