// 
//  MainInteractor.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import Foundation
import CoreLocation
import Adhan

class MainInteractor: MainPresenterToInteractor {
    weak var presenter: MainInteractorToPresenter?
    private var locationManager: CLLocationManager = CLLocationManager()
    
    func getPrayerTimes() {
        let cal = Calendar(identifier: Calendar.Identifier.iso8601)
        let date = cal.dateComponents([.year, .month, .day], from: Date())
        
        if let currentLoc = locationManager.location?.coordinate {
            let coordinates = Coordinates(latitude: currentLoc.latitude, longitude: currentLoc.longitude)
            var params = CalculationMethod.moonsightingCommittee.params
            params.madhab = .hanafi
            
            if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
//                let formatter = DateFormatter()
//                formatter.timeStyle = .long
//                formatter.timeZone = TimeZone(identifier: "Asia/Jakarta")!

                let times = MuslimPrayerTimes(fajr: prayers.fajr, sunrise: prayers.sunrise, dhuhr: prayers.dhuhr, asr: prayers.asr, maghrib: prayers.maghrib, isha: prayers.isha)
            
            } else {
                
            }
            
        } else {
            
        }
    }
        
}
