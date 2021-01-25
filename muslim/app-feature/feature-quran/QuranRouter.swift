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
    
    func navigateToVerse(chapter_id: Int, verse_count: Int, from: QuranPresenterToView?) {
        if let vc = from as? UIViewController {
            let verseController = QuranVerseRouter.createQuranVerseModule(chapter_id: chapter_id, verse_count: verse_count)
            vc.navigationController?.pushViewController(verseController, animated: true)
        }
    }
}
