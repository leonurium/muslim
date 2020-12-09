//
//  MainTimeTableCell.swift
//  muslim
//
//  Created by Rangga Leo on 09/12/20.
//

import UIKit

class MainTimeTableCell: UITableViewCell {
    
    @IBOutlet weak var container_round: UIView!
    @IBOutlet weak var container_view: UIStackView!
    
    struct source {
        static var nib: UINib = UINib(nibName: String(describing: MainTimeTableCell.self), bundle: Bundle(for: MainTimeTableCell.self))
        static var identifier: String = String(describing: MainTimeTableCell.self)
    }
    
    var prayers: MuslimPrayerTimes? {
        didSet {
            updateUI()
        }
    }
    
    var currentPrayer: MuslimPrayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        updateUI()
    }
    
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        container_round.layer.cornerRadius = 15
        container_round.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        container_round.layer.shadowOffset = CGSize(width: 0, height: 0)
        container_round.layer.shadowRadius = 10.0
        container_round.layer.shadowOpacity = 30.0
        container_round.layer.masksToBounds = false
        
        container_view.backgroundColor = .clear
        container_view.spacing = 0
        container_view.distribution = .fill
    }
    
    private func updateUI() {
        let prayers = MuslimPrayer.allCases
        for prayer in prayers {
            if prayer == currentPrayer {
                let btn_prayer = UIMLabelTitle()
                btn_prayer.textColor = UIMColor.mine_shaft.get()
                btn_prayer.setFontSize(14)
                btn_prayer.textAlignment = .left
                
            } else {
                let btn_prayer = UIMLabelBody()
                btn_prayer.textColor = UIMColor.mine_shaft.get()
                btn_prayer.setFontSize(14)
                btn_prayer.textAlignment = .left
            }
        }
    }
}
