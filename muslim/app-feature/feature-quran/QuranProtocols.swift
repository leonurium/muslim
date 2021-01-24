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
    
    func updateLabel(text: String)
}

// MARK: Interactor -
protocol QuranPresenterToInteractor: class {
    var presenter: QuranInteractorToPresenter?  { get set }
    
    func getQuran(surahNumber: Int?, ayahNumber: [Int])
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
}

protocol QuranInteractorToPresenter: class {
    func didGetQuran(chapters: [QuranManager.QuranChapter])
    func failGetQuran(title: String, error: String)
}
