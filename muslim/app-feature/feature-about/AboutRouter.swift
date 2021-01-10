// 
//  AboutRouter.swift
//  muslim
//
//  Created by Rangga Leo on 10/01/21.
//

import UIKit

class AboutRouter: AboutPresenterToRouter {
    
    static func createAboutModule() -> UIViewController {
        let view: UIViewController & AboutPresenterToView = AboutView()
        let presenter: AboutViewToPresenter & AboutInteractorToPresenter = AboutPresenter()
        let interactor: AboutPresenterToInteractor = AboutInteractor()
        let router: AboutPresenterToRouter = AboutRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
