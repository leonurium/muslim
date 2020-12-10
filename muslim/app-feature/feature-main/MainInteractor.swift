// 
//  MainInteractor.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import Foundation
import CoreLocation
import Adhan

class MainInteractor: NSObject, MainPresenterToInteractor {
    weak var presenter: MainInteractorToPresenter?
    private var locationManager: CLLocationManager = {
        $0.requestWhenInUseAuthorization()
        $0.startUpdatingHeading()
        $0.startUpdatingLocation()
        return $0
    }(CLLocationManager())
    
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
                presenter?.didGetPrayerTimes(times: times)
            
            } else {
                presenter?.failGetPrayerTimes(title: LTitleAlert.error.localized, message: LError.fail_get_prayer_times.localized)
            }
            
        } else {
            presenter?.failGetPrayerTimes(title: LTitleAlert.error.localized, message: LError.not_found_current_location.localized)
        }
    }
    
    func getQiblaDirection() {
        locationManager.delegate = self
    }
}

extension MainInteractor: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if let currentLoc = locationManager.location?.coordinate {
            let angleDirection = Qibla(coordinates: Coordinates(latitude: currentLoc.latitude, longitude: currentLoc.longitude)).direction
            let angel = (Double.pi/180) * -(Double(newHeading.trueHeading) - angleDirection)
            debugLog(angel)
            presenter?.didGetQiblaDirection(angle: angel)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        presenter?.failGetLocation(title: LTitleAlert.error.localized, message: error.localizedDescription)
    }
}
