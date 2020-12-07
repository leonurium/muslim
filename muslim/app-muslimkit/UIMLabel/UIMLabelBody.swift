//
//  UIMLabelBody.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import UIKit

class UIMLabelBody: UILabel {
    
    private var fontSize: CGFloat = 0 {
        didSet {
            self.font = UIMFont.roman.size(fontSize)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        let size_font: CGFloat  = self.font.pointSize
        font = UIMFont.roman.size(size_font)
    }
    
    public func setFontSize(_ size: CGFloat) {
        fontSize = size
    }
}
