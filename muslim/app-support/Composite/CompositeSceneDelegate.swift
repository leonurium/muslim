//
//  CompositeSceneDelegate.swift
//  muslim
//
//  Created by Rangga Leo on 13/12/20.
//

import UIKit

@available(iOS 13.0, *)
typealias SceneDelegateType = UIResponder & UIWindowSceneDelegate

@available(iOS 13.0, *)
class CompositeSceneDelegate: SceneDelegateType {
    private let sceneDelegates: [SceneDelegateType]
    
    init(sceneDelegates: [SceneDelegateType]) {
        self.sceneDelegates = sceneDelegates
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        sceneDelegates.forEach({ $0.scene?(scene, willConnectTo: session, options: connectionOptions) })
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        sceneDelegates.forEach({ $0.sceneWillResignActive?(scene) })
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        sceneDelegates.forEach({ $0.sceneDidEnterBackground?(scene) })
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        sceneDelegates.forEach({ $0.sceneWillEnterForeground?(scene) })
    }
}
