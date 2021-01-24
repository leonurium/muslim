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
}

// MARK: Interactor -
protocol QuranVersePresenterToInteractor: class {
    var presenter: QuranVerseInteractorToPresenter?  { get set }
}


// MARK: Router -
protocol QuranVersePresenterToRouter: class {
    static func createQuranVerseModule() -> UIViewController
}

// MARK: Presenter -
protocol QuranVerseViewToPresenter: class {
    var view: QuranVersePresenterToView? {get set}
    var interactor: QuranVersePresenterToInteractor? {get set}
    var router: QuranVersePresenterToRouter? {get set}
}

protocol QuranVerseInteractorToPresenter: class {
}
