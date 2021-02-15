//
//  UIMButtonIcon.swift
//  muslim
//
//  Created by Rangga Leo on 14/02/21.
//

import UIKit

class UIMButtonIcon: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    private func setupViews() {
        tintColor = UIMColor.brandColor()
        backgroundColor = UIMColor.secondBrandColor()
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
        layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 4
        layer.shadowOpacity = 4
    }
    
    func setIcon(image: UIImage?) {
        setImage(image, for: .normal)
    }
    
    func setInset(insets: UIEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)) {
        imageEdgeInsets = insets
    }
    
    func setCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
    }
}
