// 
//  QuranVerseProtocols.swift
//  muslim
//
//  Created by Rangga Leo on 24/01/21.
//

import UIKit


// MARK: View -
protocol QuranVersePresenterToView: class {
    var presenter: QuranVerseViewToPresenter? { get set }
    
    func setupViews()
    func showLoaderIndicator()
    func dismissLoaderIndicator()
    func showAlert(title: String, message: String, okCompletion: (() -> Void)?)
    func showAlertConfirm(title: String, message: String, okCompletion: (() -> Void)?, cancleCompletion: (() -> Void)?)
    func reloadTableView()
}

// MARK: Interactor -
protocol QuranVersePresenterToInteractor: class {
    var presenter: QuranVerseInteractorToPresenter?  { get set }
    
    func getVerse(chapter_id: Int, verse_ids: [Int])
}


// MARK: Router -
protocol QuranVersePresenterToRouter: class {
    static func createQuranVerseModule(chapter_id: Int, verse_count: Int) -> UIViewController
}

// MARK: Presenter -
protocol QuranVerseViewToPresenter: class {
    var view: QuranVersePresenterToView? {get set}
    var interactor: QuranVersePresenterToInteractor? {get set}
    var router: QuranVersePresenterToRouter? {get set}
    var chapter_id: Int { get set }
    
    func didLoad()
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> QuranManager.QuranVerse
    func requestVerse()
}

protocol QuranVerseInteractorToPresenter: class {
    func didGetQuran(verses: [QuranManager.QuranVerse])
    func failGetQuran(title: String, error: String)
}
