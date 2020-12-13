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
    func didBecomeActive()
    func willTerminate()
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
    
    func didBecomeActive() {
        self.didBecomeActive()
    }
    
    func willTerminate() {
        self.willTerminate()
    }
}

class AppLifecycleMediator: NSObject {
    private var listeners: [AppLifecycleListener] = []
    
    init(listeners: [AppLifecycleListener]) {
        super.init()
        self.listeners.append(contentsOf: listeners)
        debugLog(listeners)
        subscribe()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func subscribe() {
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: .willResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: .didEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: .willEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: .didBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willTerminate), name: .willTerminate, object: nil)
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
    
    @objc private func didBecomeActive() {
        listeners.forEach({ $0.didBecomeActive() })
    }
    
    @objc private func willTerminate() {
        listeners.forEach({ $0.willTerminate() })
    }
}
