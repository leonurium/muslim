// 
//  PrayerTimeTableRouter.swift
//  muslim
//
//  Created by Developer on 16/02/21.
//

import UIKit

class PrayerTimeTableRouter: PrayerTimeTablePresenterToRouter {
    
    static func createPrayerTimeTableModule() -> UIViewController {
        let view: UIViewController & PrayerTimeTablePresenterToView = PrayerTimeTableView()
        let presenter: PrayerTimeTableViewToPresenter & PrayerTimeTableInteractorToPresenter = PrayerTimeTablePresenter()
        let interactor: PrayerTimeTablePresenterToInteractor = PrayerTimeTableInteractor()
        let router: PrayerTimeTablePresenterToRouter = PrayerTimeTableRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
