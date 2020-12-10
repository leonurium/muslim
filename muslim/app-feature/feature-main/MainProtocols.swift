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
    func reloadTableView()
    func updateIntevalView(remaining: String)
}

// MARK: Interactor -
protocol MainPresenterToInteractor: class {
    var presenter: MainInteractorToPresenter?  { get set }
    
    func getPrayerTimes()
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
    func cellForRowClock() -> MainClock?
    func cellForRowTimeTable() -> MainTimeTable?
    func cellForRowQibla() -> MainQibla?
}

protocol MainInteractorToPresenter: class {
    func didGetPrayerTimes(times: MuslimPrayerTimes)
    func failGetPrayerTimes(title: String, message: String)
}
