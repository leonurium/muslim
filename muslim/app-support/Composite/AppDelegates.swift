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
        
        let navigationController = UINavigationController(rootViewController: getInitial())
        navigationController.navigationBar.isHidden = true
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        AppLifecycleMediator.push(name: .willResignActive)
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        AppLifecycleMediator.push(name: .didEnterBackground)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        AppLifecycleMediator.push(name: .willEnterForeground)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        AppLifecycleMediator.push(name: .didBecomeActive)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        AppLifecycleMediator.push(name: .willTerminate)
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
