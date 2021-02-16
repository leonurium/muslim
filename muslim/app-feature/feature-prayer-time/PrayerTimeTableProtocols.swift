// 
//  PrayerTimeTableProtocols.swift
//  muslim
//
//  Created by Developer on 16/02/21.
//

import UIKit

// MARK: View -
protocol PrayerTimeTablePresenterToView: class {
    var presenter: PrayerTimeTableViewToPresenter? { get set }
    
    func setupViews()
    func reloadTableView()
    func showLoaderIndicator()
    func dismissLoaderIndicator()
}

// MARK: Interactor -
protocol PrayerTimeTablePresenterToInteractor: class {
    var presenter: PrayerTimeTableInteractorToPresenter?  { get set }
    
    func requestData()
}

// MARK: Router -
protocol PrayerTimeTablePresenterToRouter: class {
    static func createPrayerTimeTableModule() -> UIViewController
}

// MARK: Presenter -
protocol PrayerTimeTableViewToPresenter: class {
    var view: PrayerTimeTablePresenterToView? {get set}
    var interactor: PrayerTimeTablePresenterToInteractor? {get set}
    var router: PrayerTimeTablePresenterToRouter? {get set}
    
    func didLoad()
    func numberOfRowsInSection() -> Int
    func cellForRowTimeTable() -> MainTimeTable?
}

protocol PrayerTimeTableInteractorToPresenter: class {
    func didGetPrayerTimes(times: MuslimPrayerTimes)
    func failGetPrayerTimes(title: String, message: String)
    func failGetLocation(title: String, message: String)
}
