//
//  QuranVerseDefaultCell.swift
//  muslim
//
//  Created by Rangga Leo on 24/01/21.
//

import UIKit

class QuranVerseDefaultCell: UITableViewCell {
    
    @IBOutlet weak var stack_container: UIStackView!
    @IBOutlet weak var lbl_title: UIMLabelTitle!
    @IBOutlet weak var lbl_body: UIMLabelBody!
    
    struct source {
        static var nib: UINib = UINib(nibName: String(describing: QuranVerseDefaultCell.self), bundle: Bundle(for: QuranVerseDefaultCell.self))
        static var identifier: String = String(describing: QuranVerseDefaultCell.self)
    }
    
    var verse: QuranManager.QuranVerse? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        stack_container.backgroundColor = .clear
        stack_container.spacing = 8
        stack_container.distribution = .fill
        
        lbl_title.numberOfLines = 0
        lbl_body.numberOfLines = 0
        lbl_title.textAlignment = .right
        
        lbl_title.textColor = UIMColor.white.get()
        lbl_body.textColor = UIMColor.white.get()
        
        lbl_title.setFontSize(18)
        lbl_body.setFontSize(16)
    }
    
    private func updateUI() {
        lbl_title.text = verse?.verse
        lbl_body.text = verse?.verse_locale.indonesia
    }
}
