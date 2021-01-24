//
//  SceneDelegates.swift
//  muslim
//
//  Created by Rangga Leo on 13/12/20.
//

import UIKit

enum SceneDelegateFactory {
    @available(iOS 13.0, *)
    static func makeDefault(window: UIWindow? = nil) -> SceneDelegateType {
        return CompositeSceneDelegate(sceneDelegates: [
            StartupSceneDelegate(window: window),
            ThirdPartySceneDelegate()
        ])
    }
}

@available(iOS 13.0, *)
class StartupSceneDelegate: SceneDelegateType {
    var window: UIWindow?
    
    init(window: UIWindow? = nil) {
        self.window = window
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let navigationController = UINavigationController(rootViewController: getInitial())
        navigationController.navigationBar.isHidden = true
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    private func getInitial() -> UIViewController {
        return QuranRouter.createQuranModule()
    }
}

@available(iOS 13.0, *)
class ThirdPartySceneDelegate: SceneDelegateType {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
    }
}
