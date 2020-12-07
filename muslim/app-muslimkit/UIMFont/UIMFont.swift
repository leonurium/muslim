//
//  UIMFont.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import UIKit

enum UIMFont: String {
    case light  = "Avenir-Light"
    case book   = "Avenir-Book"
    case roman  = "Avenir-Roman"
    case medium = "Avenir-Medium"
    case heavy  = "Avenir-Heavy"
    case black  = "Avenir-Black"
    
    func size(_ of: CGFloat) -> UIFont {
        guard let font = UIFont(name: self.rawValue, size: of) else { return UIFont() }
        return font
    }
}
