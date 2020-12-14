//
//  AppDelegates.swift
//  muslim
//
//  Created by Rangga Leo on 13/12/20.
//

import UIKit
import Firebase
import Siren

enum AppDelegateFactory {
    static func makeDefault(window: UIWindow? = nil) -> AppDelegateType {
        return CompositeAppDelegate(appDelegates: [
            StartupAppDelegate(window: window),
            ThirdPartyAppDelegate(),
            NotificationAppDelegate()
        ])
    }
}

class StartupAppDelegate: AppDelegateType {
    var window: UIWindow?
    
    init(window: UIWindow? = nil) {
        self.window = window
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let controller = getInitial()
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.isHidden = true
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
    private func getInitial() -> UIViewController {
        return MainRouter.createMainModule()
    }
}

class ThirdPartyAppDelegate: AppDelegateType {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        checkVersion()
        return true
    }
    
    private func checkVersion() {
        let siren = Siren.shared
        let rules = RulesManager(majorUpdateRules: .critical, minorUpdateRules: .annoying, patchUpdateRules: .default, revisionUpdateRules: .relaxed, showAlertAfterCurrentVersionHasBeenReleasedForDays: 0)
        siren.rulesManager = rules
        siren.wail()
    }
}

class NotificationAppDelegate: AppDelegateType {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        requestPermissionNotification(application: application)
        return true
    }
    
    private func requestPermissionNotification(application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
    }
}

extension NotificationAppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
                
        let id = notification.request.identifier
        debugLog("Received notification with ID = \(id)")
        
        // Print full message.
        debugLog(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([.alert, .badge, .sound])
//        completionHandler([])
    }
}
