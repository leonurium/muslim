// 
//  QuranRouter.swift
//  muslim
//
//  Created by Rangga Leo on 18/01/21.
//

import UIKit

class QuranRouter: QuranPresenterToRouter {
    
    static func createQuranModule() -> UIViewController {
        let view: UIViewController & QuranPresenterToView = QuranView()
        let presenter: QuranViewToPresenter & QuranInteractorToPresenter = QuranPresenter()
        let interactor: QuranPresenterToInteractor = QuranInteractor()
        let router: QuranPresenterToRouter = QuranRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
