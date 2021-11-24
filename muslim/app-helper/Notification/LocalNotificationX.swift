//
//  LocalNotificationX.swift
//  muslim
//
//  Created by Rangga Leo on 10/12/20.
//

import Foundation
import UserNotifications
import CoreLocation

struct LocalNotificationModelX: Equatable {
    let id: String
    let title: String
    let body: String
    let sound: UNNotificationSound
    let repeats: Bool
    let trigger: TriggerType
    
    enum TriggerType {
        case calendar(_ date: Date)
        case location(_ region: CLRegion)
        case timeInterval(_ timeInterval: TimeInterval)
    }
    
    static func == (lhs: LocalNotificationModelX, rhs: LocalNotificationModelX) -> Bool {
        lhs.id == rhs.id
    }
}

class LocalNotificationX {
    static var shared = LocalNotificationX()
    private var notifications: [LocalNotificationModelX] = []
    private var notif: UNUserNotificationCenter?
    
    init() {
        notif = UNUserNotificationCenter.current()
    }
    
    private func requestAuthorization() {
        notif?.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                self.scheduleNotifications()
            }
        }
    }
    
    private func createTriggerCalendar(date: Date, repeats: Bool) -> UNCalendarNotificationTrigger {
        let date = Calendar.current.dateComponents(
            [
                .calendar,
                .day,
                .era,
                .hour,
                .minute,
                .month,
                .nanosecond,
                .quarter,
                .second,
                .timeZone,
                .weekOfMonth,
                .weekOfYear,
                .weekday,
                .weekdayOrdinal,
                .year,
                .yearForWeekOfYear
            ], from: date)
        
        let component = DateComponents(calendar: date.calendar, timeZone: date.timeZone, era: date.era, year: date.year, month: date.month, day: date.day, hour: date.hour, minute: date.minute, second: date.second, nanosecond: date.nanosecond, weekday: date.weekday, weekdayOrdinal: date.weekdayOrdinal, quarter: date.quarter, weekOfMonth: date.weekOfMonth, weekOfYear: date.weekOfYear, yearForWeekOfYear: date.yearForWeekOfYear)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: repeats)
        return trigger
    }
    
    private func scheduleNotifications() {
        for notification in notifications {
            let content     = UNMutableNotificationContent()
            content.title   = notification.title
            content.body    = notification.body
            content.sound   = notification.sound
            
            var trigger: UNNotificationTrigger?
            switch notification.trigger {
            case .calendar(let date):
                trigger = createTriggerCalendar(date: date, repeats: notification.repeats)
            case .location(let region):
                trigger = UNLocationNotificationTrigger(region: region, repeats: notification.repeats)
            case .timeInterval(let interval):
                trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: notification.repeats)
            }
            
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            notif?.add(request) { error in
                guard error == nil else { return }
                debugLog("Notification scheduled! --- ID = \(notification.id) with type \(notification.trigger)")
            }
        }
    }
    
    func addNotification(id: String = UUID().uuidString, title: String, body: String?, trigger: LocalNotificationModelX.TriggerType, repeats: Bool = false) {
        let notifModel = LocalNotificationModelX(id: id, title: title, body: body ?? "", sound: .default, repeats: repeats, trigger: trigger)
        if !notifications.contains(notifModel) {
            self.notifications.append(notifModel)
        }
    }
    
    func addNotification(id: String = UUID().uuidString, title: String, body: String?, sound: String?, trigger: LocalNotificationModelX.TriggerType, repeats: Bool = false) {
        var soundNotif: UNNotificationSound = .default
        if let soundName = sound {
            soundNotif = UNNotificationSound(named: UNNotificationSoundName(soundName))
        }
        let notifModel = LocalNotificationModelX(id: id, title: title, body: body ?? "", sound: soundNotif, repeats: repeats, trigger: trigger)
        if !notifications.contains(notifModel) {
            self.notifications.append(notifModel)
        }
    }
    
    func save() {
        notif?.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break // Do nothing
            }
        }
    }
    
    func getPendingNotifications(completion: @escaping ([UNNotificationRequest]) -> Void) {
        notif?.getPendingNotificationRequests { (request) in
            completion(request)
        }
    }
    
    func cancel(identifier: [String]) {
        notif?.removePendingNotificationRequests(withIdentifiers: identifier)
        notifications.removeAll { (notif) -> Bool in
            return identifier.contains(notif.id)
        }
    }
    
    func cancelAllNotifications() {
        notif?.removeAllPendingNotificationRequests()
        notifications.removeAll()
    }
}
