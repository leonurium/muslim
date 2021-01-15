//
//  PrayerManager.swift
//  muslim
//
//  Created by Rangga Leo on 15/01/21.
//

import CoreLocation
import Adhan
import PrayerIDN

enum Countries: String {
    case indonesia
}

protocol PrayerManagerDelegate: class {
    func didGetTimes(times: MuslimPrayerTimes)
    func didGetQibla(direction: Double)
    func failRequest(error: Error)
}

class PrayerManager: NSObject {
    static let shared = PrayerManager()
    
    private var locationManager: CLLocationManager = {
//        $0.requestWhenInUseAuthorization()
        $0.startUpdatingHeading()
        $0.startUpdatingLocation()
        return $0
    }(CLLocationManager())
    
    weak var delegate: PrayerManagerDelegate?
    private var timer : Timer?
    private var isAllowRequest: Bool = true
    private var lastPrayerToday: Date?
    
    override init() {
        super.init()
        locationManager.delegate = self
        timer = Timer(timeInterval: 300, target: self, selector: #selector(didChangeTime), userInfo: nil, repeats: true)
    }
    
    @objc private func didChangeTime() {
        isAllowRequest = true
    }
    
    private func getPrayerTimes(location: CLLocation) {
        let now = Date()
        let cal = Calendar(identifier: Calendar.Identifier.iso8601)
        var date = cal.dateComponents([.year, .month, .day], from: now)
        
        if let lastPrayer = lastPrayerToday {
            if now >= lastPrayer {
                if let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now) {
                    date = cal.dateComponents([.year, .month, .day], from: tomorrow)
                    lastPrayerToday = nil
                }
            }
        }
        
        getPlace(for: location) { (placemark) in
            guard
                let country = placemark?.country?.lowercased(),
                country == Countries.indonesia.rawValue
            else {
                
                let coordinates = Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                var params = CalculationMethod.moonsightingCommittee.params
                params.madhab = .hanafi
                
                if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
                    let times = MuslimPrayerTimes(fajr: prayers.fajr, sunrise: prayers.sunrise, dhuhr: prayers.dhuhr, asr: prayers.asr, maghrib: prayers.maghrib, isha: prayers.isha)
                    if now >= times.isha {
                        self.lastPrayerToday = times.isha
                        self.getPrayerTimes(location: location)
                        return
                    }
                    self.delegate?.didGetTimes(times: times)
                
                } else {
                    let error = NSError(domain: LError.fail_get_prayer_times.localized, code: 0, userInfo: nil)
                    self.delegate?.failRequest(error: error)
                }
                return
            }
            
            let prayer = PrayerIDN(coordinate: PrayerIDN.Coordinate(lat: location.coordinate.latitude, long: location.coordinate.longitude), date: date)
            prayer.delegate = self
        }
    }
    
    private func getPlace(for location: CLLocation, completion: @escaping (CLPlacemark?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let err = error {
                self.delegate?.failRequest(error: err)
                completion(nil)
                return
            }
            
            if let place = placemarks?.last {
                completion(place)
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}

extension PrayerManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, isAllowRequest else { return }
        isAllowRequest = false
        getPrayerTimes(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if let currentLoc = locationManager.location?.coordinate {
            let angleDirection = Qibla(coordinates: Coordinates(latitude: currentLoc.latitude, longitude: currentLoc.longitude)).direction
            let angel = (Double.pi/180) * -(Double(newHeading.trueHeading) - angleDirection)
            delegate?.didGetQibla(direction: angel)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.failRequest(error: error)
    }
}

extension PrayerManager: PrayerDelegate {
    func failWhenRequestApi(error: Error) {
        delegate?.failRequest(error: error)
    }
    
    func failWhenDefinePlaceMark(error: Error) {
        delegate?.failRequest(error: error)
    }
    
    func didUpdateTimes(times: PrayerIDN.Times) {
        let muslimTimes = MuslimPrayerTimes(fajr: times.fajr, sunrise: times.sunrise, dhuhr: times.dhuhr, asr: times.asr, maghrib: times.maghrib, isha: times.isha)
        
        let now = Date()
        if now >= muslimTimes.isha {
            lastPrayerToday = muslimTimes.isha
            guard let location = locationManager.location else { return }
            getPrayerTimes(location: location)
            return
        }
        delegate?.didGetTimes(times: muslimTimes)
    }
}
