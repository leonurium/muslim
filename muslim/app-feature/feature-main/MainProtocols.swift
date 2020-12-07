// 
//  MainProtocols.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import UIKit


// MARK: View -
protocol MainPresenterToView: class {
    var presenter: MainViewToPresenter? { get set }
    
    func setupViews()
}

// MARK: Interactor -
protocol MainPresenterToInteractor: class {
    var presenter: MainInteractorToPresenter?  { get set }
}


// MARK: Router -
protocol MainPresenterToRouter: class {
    static func createMainModule() -> UIViewController
}

// MARK: Presenter -
protocol MainViewToPresenter: class {
    var view: MainPresenterToView? {get set}
    var interactor: MainPresenterToInteractor? {get set}
    var router: MainPresenterToRouter? {get set}
    
    func didLoad()
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath)
}

protocol MainInteractorToPresenter: class {
}
