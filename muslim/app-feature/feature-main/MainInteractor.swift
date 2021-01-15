// 
//  MainInteractor.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import Foundation

class MainInteractor: NSObject, MainPresenterToInteractor {
    weak var presenter: MainInteractorToPresenter?
    
    func requestData() {
        PrayerManager.shared.delegate = self
    }
}

extension MainInteractor: PrayerManagerDelegate {
    func didGetTimes(times: MuslimPrayerTimes) {
        presenter?.didGetPrayerTimes(times: times)
    }
    
    func didGetQibla(direction: Double) {
        presenter?.didGetQiblaDirection(angle: direction)
    }
    
    func failRequest(error: Error) {
        presenter?.failGetLocation(title: LTitleAlert.error.localized, message: error.localizedDescription)
    }
}
