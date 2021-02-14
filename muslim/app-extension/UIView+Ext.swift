//
//  UIView+Ext.swift
//  muslim
//
//  Created by Rangga Leo on 12/02/21.
//

import UIKit

extension UIView {
    func setMask(with hole: CGRect, corner radius: CGFloat) {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = hole
        let roundedRectPath = UIBezierPath(roundedRect: hole, cornerRadius: radius)
        let path = UIBezierPath(rect: bounds)
        path.append(roundedRectPath)
        maskLayer.fillRule = .evenOdd
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
        layer.masksToBounds = true
    }
}

