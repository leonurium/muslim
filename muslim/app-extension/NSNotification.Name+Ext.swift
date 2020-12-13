//
//  NSNotification.Name+Ext.swift
//  muslim
//
//  Created by Rangga Leo on 13/12/20.
//

import Foundation

extension NSNotification.Name {
    static let willResignActive = Notification.Name(Bundle.main.bundleIdentifier ?? "app" + ".willResignActive")
    static let didEnterBackground = Notification.Name(Bundle.main.bundleIdentifier ?? "app" + ".didEnterBackground")
    static let willEnterForeground = Notification.Name(Bundle.main.bundleIdentifier ?? "app" + ".willEnterForeground")
    static let didBecomeActive = Notification.Name(Bundle.main.bundleIdentifier ?? "app" + ".didBecomeActive")
    static let willTerminate = Notification.Name(Bundle.main.bundleIdentifier ?? "app" + ".willTerminate")
}
