//
//  MainTodayVerseCell.swift
//  muslim
//
//  Created by Developer on 15/02/21.
//

import UIKit

struct MainTodayVerse {
    let title : String
    let subTitle : String
    let text: String
    let subText: String
}

protocol MainTodayVerseCellDelegate: class {
    func didTapShare(cell: MainTodayVerseCell)
}

class MainTodayVerseCell: UITableViewCell {
    @IBOutlet weak var container_view: UIView!
    @IBOutlet weak var container_stack_header: UIStackView!
    @IBOutlet weak var container_stack_body: UIStackView!
    @IBOutlet weak var lbl_title: UIMLabelTitle!
    @IBOutlet weak var lbl_subtitle: UIMLabelBody!
    @IBOutlet weak var btn_share: UIMButtonIcon!
    @IBOutlet weak var lbl_text: UIMLabelTitle!
    @IBOutlet weak var lbl_subtext: UIMLabelBody!
    
    struct source {
        static var nib: UINib = UINib(nibName: String(describing: MainTodayVerseCell.self), bundle: Bundle(for: MainTodayVerseCell.self))
        static var identifier: String = String(describing: MainTodayVerseCell.self)
    }
    
    var data: MainTodayVerse? {
        didSet {
            updateUI()
        }
    }
    
    weak var delegate: MainTodayVerseCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        container_stack_header.backgroundColor = .clear
        container_stack_body.backgroundColor = .clear
        container_view.backgroundColor = UIMColor.white.get()
        
        container_view.layer.cornerRadius = 10
        container_view.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        container_view.layer.shadowOffset = CGSize(width: 0, height: 0)
        container_view.layer.shadowRadius = 4
        container_view.layer.shadowOpacity = 4
        
        container_stack_body.spacing = 8
        container_stack_header.spacing = 2
        
        let image = UIImage(identifierName: .icon_share)?.withRenderingMode(.alwaysTemplate)
        btn_share.setIcon(image: image)
        btn_share.setInset()
        btn_share.setCornerRadius(radius: 5)
        
        lbl_title.setFontSize(14)
        lbl_subtitle.setFontSize(12)
        lbl_text.setFontSize(14)
        lbl_subtext.setFontSize(14)
        
        lbl_text.numberOfLines = 0
        lbl_subtext.numberOfLines = 0
        
        lbl_text.textAlignment = .right
        lbl_subtext.textAlignment = .justified
        
        btn_share.addTarget(self, action: #selector(didTapShare(_:)), for: .touchUpInside)
    }
    
    private func updateUI() {
        lbl_title.text = data?.title
        lbl_subtitle.text = data?.subTitle
        lbl_text.text = data?.text
        lbl_subtext.text = data?.subText
    }
    
    @objc func didTapShare(_ sender: UIMButtonIcon) {
        delegate?.didTapShare(cell: self)
    }
}
