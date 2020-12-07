//
//  UIMLabelNote.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import UIKit

class UIMLabelNote: UILabel {
    
    private var fontSize: CGFloat = 0 {
        didSet {
            self.font = UIMFont.book.size(fontSize)
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
        textColor = UIMColor.dove_gray.get()
        font = UIMFont.book.size(size_font)
    }
    
    public func setFontSize(_ size: CGFloat) {
        fontSize = size
    }
}
