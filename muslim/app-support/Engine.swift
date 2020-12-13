//
//  Engine.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import Foundation
import UIKit
import Firebase
import Siren

public class Engine: NSObject {
    private var application: UIApplication?
    
    init(application: UIApplication? = nil) {
        super.init()
        self.application = application
        initialSetup()
    }
    
    func initialSetup() {
//        initial setup here
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
            Crashlytics.crashlytics().log("tes")
        }
        checkVersion()
        if let app = self.application {
            requestPermissionNotification(application: app)
        }
    }
    
    func getInitial() -> UIViewController {
        return MainRouter.createMainModule()
    }
    
    func checkVersion() {
        let siren = Siren.shared
        let rules = RulesManager(majorUpdateRules: .critical, minorUpdateRules: .annoying, patchUpdateRules: .default, revisionUpdateRules: .relaxed, showAlertAfterCurrentVersionHasBeenReleasedForDays: 0)
        siren.rulesManager = rules
        siren.wail()
    }
    
    func requestPermissionNotification(application: UIApplication) {
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

extension Engine: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
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
