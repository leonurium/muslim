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
    
    enum Quran: String {
        case bismillah = "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ"
    }
    
    enum Ext: String {
        case mp3 = ".mp3"
        case wav = ".wav"
    }
}

enum TimeIntervalConstant: TimeInterval {
    case limit_value_between_prayer = 30 // in minute
}

enum IntConstant: Int {
    case maximum_request_verse = 10
}

enum CharacterConstant: Character {
    case example = "\u{FD3E}"
    
    enum Quran: Character {
        case bismillah = "\u{FDFD}"
        case end_of_ayah_1st = "\u{FD3E}"
        case end_of_ayah_2nd = "\u{FD3F}"
        case end_of_ayah = "\u{06DD}"
    }
}

typealias SCExt = StringConstant.Ext
typealias SCQuran = StringConstant.Quran
typealias CCQuran = CharacterConstant.Quran
