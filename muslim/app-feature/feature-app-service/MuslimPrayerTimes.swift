//
//  MuslimPrayerTimes.swift
//  muslim
//
//  Created by Rangga Leo on 08/12/20.
//

import Foundation


struct MuslimPrayerTimes {
    let place: String?
    let fajr: Date
    let sunrise: Date
    let dhuhr: Date
    let asr: Date
    let maghrib: Date
    let isha: Date
    
    func currentPrayer(at time: Date = Date()) -> MuslimPrayer? {
        if isha.timeIntervalSince(time) <= 0 {
            return .isha
        } else if maghrib.timeIntervalSince(time) <= 0 {
            return .maghrib
        } else if asr.timeIntervalSince(time) <= 0 {
            return .asr
        } else if dhuhr.timeIntervalSince(time) <= 0 {
            return .dhuhr
        } else if sunrise.timeIntervalSince(time) <= 0 {
            return .sunrise
        } else if fajr.timeIntervalSince(time) <= 0 {
            return .fajr
        }

        return nil
    }
    
    public func nextPrayer(at time: Date = Date()) -> MuslimPrayer? {
        if isha.timeIntervalSince(time) <= 0 {
            return nil
        } else if maghrib.timeIntervalSince(time) <= 0 {
            return .isha
        } else if asr.timeIntervalSince(time) <= 0 {
            return .maghrib
        } else if dhuhr.timeIntervalSince(time) <= 0 {
            return .asr
        } else if sunrise.timeIntervalSince(time) <= 0 {
            return .dhuhr
        } else if fajr.timeIntervalSince(time) <= 0 {
            return .sunrise
        }

        return .fajr
    }
    
    public func time(for prayer: MuslimPrayer) -> Date {
        switch prayer {
        case .fajr:
            return fajr
        case .sunrise:
            return sunrise
        case .dhuhr:
            return dhuhr
        case .asr:
            return asr
        case .maghrib:
            return maghrib
        case .isha:
            return isha
        }
    }
}

enum MuslimPrayer: CaseIterable {
    case fajr
    case sunrise
    case dhuhr
    case asr
    case maghrib
    case isha
}
