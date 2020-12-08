//
//  LocalizableDelegate.swift
//  muslim
//
//  Created by Rangga Leo on 08/12/20.
//

import Foundation

protocol LocalizableDelegate {
    var rawValue: String { get }    //localize key
    var table: String? { get }
    var localized: String { get }
}

extension LocalizableDelegate {

    //returns a localized value by specified key located in the specified table
    var localized: String {
        return Bundle.main.localizedString(forKey: rawValue, value: nil, table: table)
    }

    // file name, where to find the localized key
    // by default is the Localizable.string table
    var table: String? {
        return nil
    }
}

extension String: LocalizableDelegate {
    var rawValue: String {
        return self
    }
}
