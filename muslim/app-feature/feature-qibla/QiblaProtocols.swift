// 
//  QiblaProtocols.swift
//  muslim
//
//  Created by Developer on 16/02/21.
//

import UIKit

// MARK: View -
protocol QiblaPresenterToView: class {
    var presenter: QiblaViewToPresenter? { get set }
    
    func setupViews()
    func updateQiblaView(angle: Double)
    func showLoaderIndicator()
    func dismissLoaderIndicator()
}

// MARK: Interactor -
protocol QiblaPresenterToInteractor: class {
    var presenter: QiblaInteractorToPresenter?  { get set }
    
    func requestData()
}

// MARK: Router -
protocol QiblaPresenterToRouter: class {
    static func createQiblaModule() -> UIViewController
}

// MARK: Presenter -
protocol QiblaViewToPresenter: class {
    var view: QiblaPresenterToView? {get set}
    var interactor: QiblaPresenterToInteractor? {get set}
    var router: QiblaPresenterToRouter? {get set}
    
    func didLoad()
    func numberOfRowsInSection() -> Int
    func cellForRowQibla() -> MainQibla?
}

protocol QiblaInteractorToPresenter: class {
    func didGetQiblaDirection(angle: Double)
}
