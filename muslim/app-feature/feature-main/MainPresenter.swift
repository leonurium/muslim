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
//        view?.showLoaderIndicator()
        interactor?.requestData()
    }
    
    func numberOfRowsInSection() -> Int {
        return 3
    }
    
    func cellForRowClock() -> MainClock? {
        if
            let prayerTimes = times,
            let currentPrayer = prayerTimes.currentPrayer(at: PrayerManager.shared.requestDate),
            let nextPrayer = prayerTimes.nextPrayer(at: PrayerManager.shared.requestDate) {
            
            let currentPrayerTime = prayerTimes.time(for: currentPrayer)
            let nextPrayerTime = prayerTimes.time(for: nextPrayer)
            let currentPrayerString = String(describing: currentPrayer).capitalized
            let nextPrayerString = String(describing: nextPrayer).capitalized
            let now = Date()
            
            let timeFormatter = DateFormatter()
            let dateFormatter = DateFormatter()
            let titleFormatter = DateFormatter()
            timeFormatter.timeStyle = .short
            dateFormatter.dateStyle = .full
            titleFormatter.dateStyle = .medium
            
            var shouldDisplayCurrentPrayer: String = ""
            var shouldDisplayCurrentPrayerTime: String = ""
            var shouldDisplayDate: String = ""
            var shouldDisplayCountdown: String = ""
            var shouldDidplayTitle: String = ""
            
            if (now.timeIntervalSince(currentPrayerTime) / 60) >= TimeIntervalConstant.limit_value_between_prayer.rawValue {
                isPlus = false
                remaining = Int(nextPrayerTime.timeIntervalSince(now))
                let (hour, minute, second) = remaining.secondsToHoursMinutesSeconds()
                shouldDisplayCurrentPrayer = nextPrayerString
                shouldDisplayCurrentPrayerTime = timeFormatter.string(from: nextPrayerTime)
                shouldDisplayDate = dateFormatter.string(from: nextPrayerTime)
                shouldDisplayCountdown = String(format: StringConstant.format_remainig_time_minus.rawValue, hour, minute, second)
                shouldDidplayTitle = titleFormatter.string(from: nextPrayerTime)
                
            } else {
                isPlus = true
                remaining = Int(now.timeIntervalSince(currentPrayerTime))
                let (hour, minute, second) = remaining.secondsToHoursMinutesSeconds()
                shouldDisplayCurrentPrayer = currentPrayerString
                shouldDisplayCurrentPrayerTime = timeFormatter.string(from: currentPrayerTime)
                shouldDisplayDate = dateFormatter.string(from: currentPrayerTime)
                shouldDisplayCountdown = String(format: StringConstant.format_remainig_time_plus.rawValue, hour, minute, second)
                shouldDidplayTitle = titleFormatter.string(from: currentPrayerTime)
            }
            
            if timer == nil {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(didChangeTimeInterval), userInfo: nil, repeats: true)
            }
            view?.updateTitle(title: shouldDidplayTitle)
            let clock = MainClock(prayerName: shouldDisplayCurrentPrayer, current: shouldDisplayCurrentPrayerTime, remaining: shouldDisplayCountdown, date: shouldDisplayDate, placeName: times?.place ?? "")
            currentMainClock = clock
            return clock
        }
        
        return currentMainClock
    }
    
    func cellForRowMainMenu() -> [MainMenuItem] {
        var menus: [MainMenuItem] = []
        menus.append(MainMenuItem(icon: .icon_quran, type: .quran))
        menus.append(MainMenuItem(icon: .icon_qibla, type: .qibla))
        menus.append(MainMenuItem(icon: .icon_time, type: .praytime))
        return menus
    }
    
    func cellForRowTodayVerse() -> MainTodayVerse? {
        let todayVerse: MainTodayVerse = MainTodayVerse(title: "Today Verse", subTitle: "Al-Baqarah (12:118)", text: "للمصممين نص لوريم ايبسوم بالعربي عربي انجليزي لوريم ايبسوم هو نموذج افتراضي يوضع في التصاميم ", subText: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad")
        return todayVerse
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
//                    LocalNotificationX.shared.addNotification(
//                        title: String(describing: prayer).capitalized,
//                        body: "Time to pray \(timeString)",
//                        trigger: .timeInterval(timeIntervalNNotif)
//                    )
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
    
    func cellForRowQibla() -> MainQibla? {
        return MainQibla(
            image_compass: Identifier.ImageName.image_compass_1.rawValue,
            image_qibla_direction: Identifier.ImageName.image_qibla_direction_1.rawValue
        )
    }
    
    func navigateToInfo() {
        router?.navigateToInfo(from: view)
    }
    
    func navigateToQuran() {
        router?.navigateToQuran(from: view)
    }
    
    func navigateToQibla() {
        router?.navigateToQibla(from: view)
    }
    
    func navigateToPraytime() {
        router?.navigateToPraytime(from: view)
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
    
    func didGetQiblaDirection(angle: Double) {
        view?.dismissLoaderIndicator()
        view?.updateQiblaView(angle: angle)
    }
}

extension MainPresenter: MainRouterToPresenter {
    func didShowFloatingPanel() {
        view?.updateViewInteraction(enable: false)
    }
    
    func didRemoveFloatingPanel() {
        view?.updateViewInteraction(enable: true)
    }    
}
