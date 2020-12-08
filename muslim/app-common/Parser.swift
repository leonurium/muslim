//
//  Parser.swift
//  muslim
//
//  Created by Rangga Leo on 08/12/20.
//

import Foundation

func infoPlist(key: Identifier.InfoPlist) -> String? {
    return Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? String
}
