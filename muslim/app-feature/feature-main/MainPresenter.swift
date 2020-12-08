//
//  MainPresenter.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import Foundation

class MainPresenter: MainViewToPresenter {
    weak var view: MainPresenterToView?
    var interactor: MainPresenterToInteractor?
    var router: MainPresenterToRouter?
    
    private var times: MuslimPrayerTimes?
    
    func didLoad() {
        view?.setupViews()
        interactor?.getPrayerTimes()
    }
    
    func numberOfRowsInSection() -> Int {
        return 1
    }
    
    func cellForRowClockCell() {
        
    }
}

extension MainPresenter: MainInteractorToPresenter {
    func didGetPrayerTimes(times: MuslimPrayerTimes) {
        self.times = times
        view?.reloadTableView()
    }
    
    func failGetPrayerTimes(title: String, message: String) {
        
    }
}
