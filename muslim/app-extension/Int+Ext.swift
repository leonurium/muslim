//
//  Int+Ext.swift
//  muslim
//
//  Created by Rangga Leo on 09/12/20.
//

import Foundation

extension Int {
    func secondsToHoursMinutesSeconds() -> (hours: Int, minute: Int, second: Int) {
        return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
    }
}
