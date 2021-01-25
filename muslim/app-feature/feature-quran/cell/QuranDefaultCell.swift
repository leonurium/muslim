//
//  QuranDefaultCell.swift
//  muslim
//
//  Created by Rangga Leo on 24/01/21.
//

import UIKit

class QuranDefaultCell: UITableViewCell {
    
    @IBOutlet weak var stack_container: UIStackView!
    @IBOutlet weak var stack_sub_container: UIStackView!
    @IBOutlet weak var lbl_id: UIMLabelTitle!
    @IBOutlet weak var lbl_title: UIMLabelTitle!
    @IBOutlet weak var lbl_body: UIMLabelBody!
    @IBOutlet weak var lbl_arabic: UIMLabelTitle!
    
    struct source {
        static var nib: UINib = UINib(nibName: String(describing: QuranDefaultCell.self), bundle: Bundle(for: QuranDefaultCell.self))
        static var identifier: String = String(describing: QuranDefaultCell.self)
    }
    
    var chapter: QuranManager.QuranChapter? {
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
        
        stack_sub_container.backgroundColor = .clear
        stack_sub_container.spacing = 4
        stack_sub_container.distribution = .fill
        
        lbl_id.textColor = UIMColor.white.get()
        lbl_title.textColor = UIMColor.white.get()
        lbl_body.textColor = UIMColor.white.get()
        lbl_arabic.textColor = UIMColor.white.get()
        lbl_arabic.textAlignment = .right
        
        lbl_id.setFontSize(20)
        lbl_title.setFontSize(18)
        lbl_body.setFontSize(16)
        lbl_arabic.setFontSize(24)
    }
    
    private func updateUI() {
        lbl_id.text = "".addEndOfAyah(number: chapter?.id)
        lbl_title.text = chapter?.name
        lbl_body.text =
            (chapter?.place ?? "") +
            " - " +
            String(describing: chapter?.verses_count ?? 0) +
            " verses"
        lbl_arabic.text = chapter?.nameArabic
    }
}
