// 
//  PrayerTimeTableInteractor.swift
//  muslim
//
//  Created by Developer on 16/02/21.
//

import Foundation

class PrayerTimeTableInteractor: PrayerTimeTablePresenterToInteractor {
    weak var presenter: PrayerTimeTableInteractorToPresenter?
    
    func requestData() {
        PrayerManager.shared.delegate = self
    }
}

extension PrayerTimeTableInteractor: PrayerManagerDelegate {
    func didGetTimes(times: MuslimPrayerTimes) {
        presenter?.didGetPrayerTimes(times: times)
    }
    
    func didGetQibla(direction: Double) {
        //
    }
    
    func failRequest(error: Error) {
        presenter?.failGetLocation(title: LTitleAlert.error.localized, message: error.localizedDescription)
    }
}
