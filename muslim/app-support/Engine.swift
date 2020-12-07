//
//  Engine.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import Foundation
import UIKit
import Firebase
import IQKeyboardManagerSwift

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
    }
    
    func getInitial() -> UIViewController {
        return MainRouter.createMainModule()
    }
}
