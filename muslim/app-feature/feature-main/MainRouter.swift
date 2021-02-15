// 
//  MainRouter.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import UIKit

class MainRouter: MainPresenterToRouter {
    
    private static var mediator: AppLifecycleMediator?
    
    static func createMainModule() -> UIViewController {
        let view: UIViewController & MainPresenterToView & AppLifecycleListener = MainView()
        let presenter: MainViewToPresenter & MainInteractorToPresenter = MainPresenter()
        let interactor: MainPresenterToInteractor = MainInteractor()
        let router: MainPresenterToRouter = MainRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        let mediator = AppLifecycleMediator(listeners: [view])
        MainRouter.mediator = mediator
        return view
    }
    
    func navigateToInfo(from: MainPresenterToView?) {
        if let vc = from as? UIViewController {
            let nav = UINavigationController(rootViewController: AboutRouter.createAboutModule())
            vc.present(nav, animated: true, completion: nil)
        }
    }
    
    func navigateToQuran(from: MainPresenterToView?) {
        if let vc = from as? UIViewController {
            let destination = QuranRouter.createQuranModule()
            vc.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    func navigateToQibla(from: MainPresenterToView?) {
        
    }
    
    func navigateToPraytime(from: MainPresenterToView?) {
        
    }
}
