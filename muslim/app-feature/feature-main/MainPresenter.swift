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
    private var timer: Timer?
    private var remaining: Int = 0
    private var isPlus: Bool = false
    private var currentMainClock: MainClock?
    
    func didLoad() {
        view?.setupViews()
        interactor?.getPrayerTimes()
        interactor?.getQiblaDirection()
    }
    
    func numberOfRowsInSection() -> Int {
        return 3
    }
    
    func cellForRowClock() -> MainClock? {
        if
            let prayerTimes = times,
            let currentPrayer = prayerTimes.currentPrayer(),
            let nextPrayer = prayerTimes.nextPrayer() {
            
            let currentPrayerTime = prayerTimes.time(for: currentPrayer)
            let nextPrayerTime = prayerTimes.time(for: nextPrayer)
            let currentPrayerString = String(describing: currentPrayer).capitalized
            let nextPrayerString = String(describing: nextPrayer).capitalized
            let now = Date()
            
            let timeFormatter = DateFormatter()
            let dateFormatter = DateFormatter()
            timeFormatter.timeStyle = .short
            dateFormatter.dateStyle = .full
            
            var shouldDisplayCurrentPrayer: String = ""
            var shouldDisplayCurrentPrayerTime: String = ""
            var shouldDisplayDate: String = ""
            var shouldDisplayCountdown: String = ""
            
            if (now.timeIntervalSince(currentPrayerTime) / 60) >= TimeIntervalConstant.limit_value_between_prayer.rawValue {
                isPlus = false
                remaining = Int(nextPrayerTime.timeIntervalSince(now))
                let (hour, minute, second) = remaining.secondsToHoursMinutesSeconds()
                shouldDisplayCurrentPrayer = nextPrayerString
                shouldDisplayCurrentPrayerTime = timeFormatter.string(from: nextPrayerTime)
                shouldDisplayDate = dateFormatter.string(from: nextPrayerTime)
                shouldDisplayCountdown = String(format: StringConstant.format_remainig_time_minus.rawValue, hour, minute, second)
                
            } else {
                isPlus = true
                remaining = Int(now.timeIntervalSince(currentPrayerTime))
                let (hour, minute, second) = remaining.secondsToHoursMinutesSeconds()
                shouldDisplayCurrentPrayer = currentPrayerString
                shouldDisplayCurrentPrayerTime = timeFormatter.string(from: currentPrayerTime)
                shouldDisplayDate = dateFormatter.string(from: currentPrayerTime)
                shouldDisplayCountdown = String(format: StringConstant.format_remainig_time_plus.rawValue, hour, minute, second)
            }
            
            if timer == nil {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(didChangeTimeInterval), userInfo: nil, repeats: true)
            }
            let clock = MainClock(prayerName: shouldDisplayCurrentPrayer, current: shouldDisplayCurrentPrayerTime, remaining: shouldDisplayCountdown, date: shouldDisplayDate)
            currentMainClock = clock
            return clock
        }
        
        return currentMainClock
    }
    
    func cellForRowTimeTable() -> MainTimeTable? {
        if
            let prayerTimes = times,
            let currentPrayer = prayerTimes.currentPrayer(),
            let nextPrayer = prayerTimes.nextPrayer() {
            
            //delete all notif
            LocalNotificationX.shared.cancelAllNotifications()
            
            var finalPrayers: [MainTimeTablePrayerAndTimes] = []
            let prayers = MuslimPrayer.allCases
            for prayer in prayers {
                let time = prayerTimes.time(for: prayer)
                let tmpPrayer = MainTimeTablePrayerAndTimes(prayer: prayer, time: time)
                finalPrayers.append(tmpPrayer)
                
                // add notif
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                let timeString = formatter.string(from: time)
                LocalNotificationX.shared.addNotification(title: String(describing: prayer), body: "Time to pray \(timeString)", trigger: .timeInterval(time.timeIntervalSinceNow))
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
    
    func cellForRowQibla() -> MainQibla? {
        return MainQibla(
            image_compass: Identifier.ImageName.image_compass_1.rawValue,
            image_qibla_direction: Identifier.ImageName.image_qibla_direction_1.rawValue
        )
    }
    
    @objc func didChangeTimeInterval() {
        if isPlus {
            remaining += 1
            let (hour, minute, second) = remaining.secondsToHoursMinutesSeconds()
            let intervalString = String(format: StringConstant.format_remainig_time_plus.rawValue, hour, minute, second)
            view?.updateIntevalView(remaining: intervalString)
            if remaining >= (Int(TimeIntervalConstant.limit_value_between_prayer.rawValue)*60) {
                debugLog(TimeIntervalConstant.limit_value_between_prayer.rawValue*60)
                isPlus = false
                view?.reloadTableView()
            }
        } else {
            remaining -= 1
            let (hour, minute, second) = remaining.secondsToHoursMinutesSeconds()
            let intervalString = String(format: StringConstant.format_remainig_time_minus.rawValue, hour, minute, second)
            view?.updateIntevalView(remaining: intervalString)
            if remaining <= 0 {
                isPlus = true
                view?.reloadTableView()
            }
        }
    }
}

extension MainPresenter: MainInteractorToPresenter {
    func didGetPrayerTimes(times: MuslimPrayerTimes) {
        self.times = times
        view?.reloadTableView()
    }
    
    func failGetPrayerTimes(title: String, message: String) {
        debugLog(message)
    }
    
    func failGetLocation(title: String, message: String) {
        debugLog(message)
    }
    
    func didGetQiblaDirection(angle: Double) {
        view?.updateQiblaView(angle: angle)    }
}
