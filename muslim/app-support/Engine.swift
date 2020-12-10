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

public class Engine {
    init() {
        initialSetup()
    }
    
    func initialSetup() {
//        initial setup here
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
            Crashlytics.crashlytics().log("tes")
        }
        checkVersion()
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
}
