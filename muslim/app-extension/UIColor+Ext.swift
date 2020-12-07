//
//  UIColor+Ext.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import UIKit

extension UIColor {
    func isLight() -> Bool {
        // algorithm from: http://www.w3.org/WAI/ER/WD-AERT/#color-contrast
        guard let components = self.cgColor.components else { return false }
        let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
        debugLog("isLight percent", brightness)
        return brightness >= 0.5
    }
}

