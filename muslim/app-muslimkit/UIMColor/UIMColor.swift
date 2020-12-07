//
//  UIMColor.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import UIKit

enum UIMColor: String {
    case dove_gray = "696969"
    case mine_shaft = "333333"
    case white = "FFFFFF"
    case alto = "D6D6D6"
        
    func get() -> UIColor {
        return self.rawValue.hexToUIColor()
    }
}
