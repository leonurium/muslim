// 
//  AboutProtocols.swift
//  muslim
//
//  Created by Rangga Leo on 10/01/21.
//

import UIKit


// MARK: View -
protocol AboutPresenterToView: class {
    var presenter: AboutViewToPresenter? { get set }
    
    func setupViews()
    func updateContent(data: String)
}

// MARK: Interactor -
protocol AboutPresenterToInteractor: class {
    var presenter: AboutInteractorToPresenter?  { get set }
}


// MARK: Router -
protocol AboutPresenterToRouter: class {
    static func createAboutModule() -> UIViewController
}

// MARK: Presenter -
protocol AboutViewToPresenter: class {
    var view: AboutPresenterToView? {get set}
    var interactor: AboutPresenterToInteractor? {get set}
    var router: AboutPresenterToRouter? {get set}
    
    func didLoad()
}

protocol AboutInteractorToPresenter: class {
}
