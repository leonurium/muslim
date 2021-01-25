// 
//  QuranVerseRouter.swift
//  muslim
//
//  Created by Rangga Leo on 24/01/21.
//

import UIKit

class QuranVerseRouter: QuranVersePresenterToRouter {
    
    static func createQuranVerseModule(chapter_id: Int, verse_ids: [Int]) -> UIViewController {
        let view: UIViewController & QuranVersePresenterToView = QuranVerseView()
        let presenter: QuranVerseViewToPresenter & QuranVerseInteractorToPresenter = QuranVersePresenter(chapter_id: chapter_id, verse_ids: verse_ids)
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
