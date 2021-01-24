//
//  Localizable.swift
//  muslim
//
//  Created by Rangga Leo on 08/12/20.
//

import Foundation

enum Localizable {
    enum TitleAlert: String, LocalizableDelegate {
        case information
        case success
        case warning
        case error
    }
    
    enum Error: String, LocalizableDelegate {
        case something_wrong
        case not_found_current_location
        case fail_get_prayer_times
    }
    
    enum Button: String, LocalizableDelegate {
        case ok
        case cancel
    }
}

typealias LTitleAlert = Localizable.TitleAlert
typealias LError = Localizable.Error
typealias LButton = Localizable.Button
