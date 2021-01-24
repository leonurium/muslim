//
//  UIMColor.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import UIKit

// name color on https://chir.ag/projects/name-that-color/

enum UIMColor: String {
    case dove_gray = "696969" // gray dark
    case mine_shaft = "333333" // black
    case white = "FFFFFF" // white
    case alto = "D6D6D6" // gray light
    case buttercup = "F0BE0C" // orange
        
    func get() -> UIColor {
        return self.rawValue.hexToUIColor()
    }
    
    static func brandColor() -> UIColor {
        return UIMColor.mine_shaft.get()
    }
}
