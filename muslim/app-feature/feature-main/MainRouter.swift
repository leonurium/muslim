// 
//  MainRouter.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import UIKit

class MainRouter: MainPresenterToRouter {
    
    static func createMainModule() -> UIViewController {
        let view: UIViewController & MainPresenterToView = MainView()
        let presenter: MainViewToPresenter & MainInteractorToPresenter = MainPresenter()
        let interactor: MainPresenterToInteractor = MainInteractor()
        let router: MainPresenterToRouter = MainRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
