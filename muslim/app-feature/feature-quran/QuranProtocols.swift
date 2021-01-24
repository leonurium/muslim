// 
//  QuranProtocols.swift
//  muslim
//
//  Created by Rangga Leo on 18/01/21.
//

import UIKit


// MARK: View -
protocol QuranPresenterToView: class {
    var presenter: QuranViewToPresenter? { get set }
    
    func setupViews()
    func showLoaderIndicator()
    func dismissLoaderIndicator()
    func showAlert(title: String, message: String, okCompletion: (() -> Void)?)
    func showAlertConfirm(title: String, message: String, okCompletion: (() -> Void)?, cancleCompletion: (() -> Void)?)
    func reloadTableView()
}

// MARK: Interactor -
protocol QuranPresenterToInteractor: class {
    var presenter: QuranInteractorToPresenter?  { get set }
    
    func getChapter(chapter_id: Int?)
    func getVerse(chapter_id: Int, verse_ids: [Int])
}


// MARK: Router -
protocol QuranPresenterToRouter: class {
    static func createQuranModule() -> UIViewController
}

// MARK: Presenter -
protocol QuranViewToPresenter: class {
    var view: QuranPresenterToView? {get set}
    var interactor: QuranPresenterToInteractor? {get set}
    var router: QuranPresenterToRouter? {get set}
    
    func didLoad()
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> QuranManager.QuranChapter
}

protocol QuranInteractorToPresenter: class {
    func didGetQuran(chapters: [QuranManager.QuranChapter])
    func failGetQuran(title: String, error: String)
}
