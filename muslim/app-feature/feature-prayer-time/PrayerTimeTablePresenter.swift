//
//  PrayerTimeTablePresenter.swift
//  muslim
//
//  Created by Developer on 16/02/21.
//

import Foundation

class PrayerTimeTablePresenter: PrayerTimeTableViewToPresenter {
    weak var view: PrayerTimeTablePresenterToView?
    var interactor: PrayerTimeTablePresenterToInteractor?
    var router: PrayerTimeTablePresenterToRouter?
    
    private var times: MuslimPrayerTimes?
    
    func didLoad() {
        view?.setupViews()
        interactor?.requestData()
    }
    
    func numberOfRowsInSection() -> Int {
        return 1
    }
    
    func cellForRowTimeTable() -> MainTimeTable? {
        if
            let prayerTimes = times,
            let currentPrayer = prayerTimes.currentPrayer(at: PrayerManager.shared.requestDate),
            let nextPrayer = prayerTimes.nextPrayer(at: PrayerManager.shared.requestDate) {
            
            //delete all notif
            LocalNotificationX.shared.cancelAllNotifications()
            
            var finalPrayers: [MainTimeTablePrayerAndTimes] = []
            let prayers = MuslimPrayer.allCases
            for prayer in prayers {
                let time = prayerTimes.time(for: prayer)
                let tmpPrayer = MainTimeTablePrayerAndTimes(prayer: prayer, time: time)
                finalPrayers.append(tmpPrayer)
                
                // add notif
                let timeIntervalNNotif = time.timeIntervalSinceNow
                if timeIntervalNNotif > 0 {
                    let formatter = DateFormatter()
                    formatter.timeStyle = .short
                    let timeString = formatter.string(from: time)
                    var soundName: String?
                    
                    switch prayer {
                    case .fajr: soundName = Identifier.soundName.adhan_fajr_1.rawValue + SCExt.wav.rawValue
                    case .sunrise: soundName = nil
                    case .asr, .dhuhr, .isha, .maghrib: soundName = Identifier.soundName.adhan_mecca_1.rawValue + SCExt.wav.rawValue
                    }
                    LocalNotificationX.shared.addNotification(
                        title: String(describing: prayer).capitalized,
                        body: "Time to pray at \(timeString)",
                        sound: soundName,
                        trigger: .timeInterval(timeIntervalNNotif)
                    )
                    LocalNotificationX.shared.save()
                }
            }
            
            var shouldCurrentPrayer: MuslimPrayer = .fajr
            let now = Date()
            if (now.timeIntervalSince(prayerTimes.time(for: currentPrayer)) / 60) >= TimeIntervalConstant.limit_value_between_prayer.rawValue {
                shouldCurrentPrayer = nextPrayer
            } else {
                shouldCurrentPrayer = currentPrayer
            }
            
            let timeTable = MainTimeTable(prayers: finalPrayers, currentPrayer: shouldCurrentPrayer)
            return timeTable
        }
        return nil
    }
}

extension PrayerTimeTablePresenter: PrayerTimeTableInteractorToPresenter {
    func didGetPrayerTimes(times: MuslimPrayerTimes) {
        self.times = times
        view?.dismissLoaderIndicator()
        view?.reloadTableView()
    }
    
    func failGetPrayerTimes(title: String, message: String) {
        debugLog(message)
        view?.dismissLoaderIndicator()
    }
    
    func failGetLocation(title: String, message: String) {
        debugLog(message)
        view?.dismissLoaderIndicator()
    }
}
