//
//  SceneDelegate.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var sceneDelegate: SceneDelegateType? = nil

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        sceneDelegate = SceneDelegateFactory.makeDefault(window: window)
        sceneDelegate?.scene?(scene, willConnectTo: session, options: connectionOptions)
    }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        sceneDelegate?.sceneWillResignActive?(scene)
    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        sceneDelegate?.sceneWillEnterForeground?(scene)
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        sceneDelegate?.sceneDidEnterBackground?(scene)
    }
}

