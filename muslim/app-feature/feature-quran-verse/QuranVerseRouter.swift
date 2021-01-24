// 
//  QuranVerseRouter.swift
//  muslim
//
//  Created by Rangga Leo on 24/01/21.
//

import UIKit

class QuranVerseRouter: QuranVersePresenterToRouter {
    
    static func createQuranVerseModule() -> UIViewController {
        let view: UIViewController & QuranVersePresenterToView = QuranVerseView()
        let presenter: QuranVerseViewToPresenter & QuranVerseInteractorToPresenter = QuranVersePresenter()
        let interactor: QuranVersePresenterToInteractor = QuranVerseInteractor()
        let router: QuranVersePresenterToRouter = QuranVerseRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
