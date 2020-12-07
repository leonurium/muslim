//
//  UIimage+Ext.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import UIKit

extension UIImage {
    convenience init?(identifierName: Identifier.ImageName) {
        self.init(named: identifierName.rawValue)
    }
}
