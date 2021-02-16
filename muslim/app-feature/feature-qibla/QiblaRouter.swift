// 
//  QiblaRouter.swift
//  muslim
//
//  Created by Developer on 16/02/21.
//

import UIKit

class QiblaRouter: QiblaPresenterToRouter {
    
    static func createQiblaModule() -> UIViewController {
        let view: UIViewController & QiblaPresenterToView = QiblaView()
        let presenter: QiblaViewToPresenter & QiblaInteractorToPresenter = QiblaPresenter()
        let interactor: QiblaPresenterToInteractor = QiblaInteractor()
        let router: QiblaPresenterToRouter = QiblaRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
