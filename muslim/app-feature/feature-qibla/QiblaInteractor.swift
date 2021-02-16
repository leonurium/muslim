// 
//  QiblaInteractor.swift
//  muslim
//
//  Created by Developer on 16/02/21.
//

import Foundation

class QiblaInteractor: QiblaPresenterToInteractor {
    weak var presenter: QiblaInteractorToPresenter?
    
    func requestData() {
        PrayerManager.shared.delegate = self
    }
}

extension QiblaInteractor: PrayerManagerDelegate {
    func didGetTimes(times: MuslimPrayerTimes) {
        //
    }
    
    func didGetQibla(direction: Double) {
         presenter?.didGetQiblaDirection(angle: direction)
    }
    
    func failRequest(error: Error) {
        //
    }
}
