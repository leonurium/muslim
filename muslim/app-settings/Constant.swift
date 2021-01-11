//
//  Constant.swift
//  muslim
//
//  Created by Rangga Leo on 09/12/20.
//

import Foundation

enum StringConstant: String {
    case format_remainig_time_minus = "-%02i:%02i:%02i"
    case format_remainig_time_plus = "+%02i:%02i:%02i"
    
    enum Ext: String {
        case mp3 = ".mp3"
    }
}

enum TimeIntervalConstant: TimeInterval {
    case limit_value_between_prayer = 30 // in minute
}

typealias SCExt = StringConstant.Ext
