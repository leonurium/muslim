//
//  MainClockCell.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import UIKit

struct MainClock {
    let prayerName: String
    let current: String
    let remaining: String
    let date: String
}

class MainClockCell: UITableViewCell {
    
    @IBOutlet weak var container_view: UIStackView!
    @IBOutlet weak var lbl_time: UIMLabelTitle!
    @IBOutlet weak var lbl_remaining_time: UIMLabelBody!
    @IBOutlet weak var lbl_date: UIMLabelNote!
//    @IBOutlet weak var lbl_pray: UILabel!
    
    struct source {
        static var nib: UINib = UINib(nibName: String(describing: MainClockCell.self), bundle: Bundle(for: MainClockCell.self))
        static var identifier: String = String(describing: MainClockCell.self)
    }
    
    var data: MainClock? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        updateUI()
    }
    
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
//        container_view.layer.cornerRadius = 15
//        container_view.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
//        container_view.layer.shadowOffset = CGSize(width: 0, height: 0)
//        container_view.layer.shadowRadius = 10.0
//        container_view.layer.shadowOpacity = 30.0
//        container_view.layer.masksToBounds = false
        container_view.backgroundColor = .clear
        container_view.spacing = 0
        container_view.distribution = .fill
        
        lbl_time.setFontSize(50)
        lbl_remaining_time.setFontSize(14)
        lbl_date.setFontSize(14)
        
        lbl_time.textColor = UIMColor.white.get()
        lbl_remaining_time.textColor = UIMColor.white.get()
        lbl_date.textColor = UIMColor.white.get()
        
        lbl_time.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        lbl_time.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl_time.layer.shadowRadius = 10.0
        lbl_time.layer.shadowOpacity = 30.0
        lbl_time.layer.masksToBounds = false
        
        lbl_remaining_time.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        lbl_remaining_time.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl_remaining_time.layer.shadowRadius = 10.0
        lbl_remaining_time.layer.shadowOpacity = 30.0
        lbl_remaining_time.layer.masksToBounds = false
        
        lbl_date.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        lbl_date.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl_date.layer.shadowRadius = 10.0
        lbl_date.layer.shadowOpacity = 30.0
        lbl_date.layer.masksToBounds = false
    }
    
    private func updateUI() {
        lbl_time.text = data?.current
        lbl_remaining_time.text = "\(data?.prayerName ?? "") (\(data?.remaining ?? ""))"
        lbl_date.text = data?.date
    }
    
    func updateIntervalView(newInterval: String) {
        lbl_remaining_time.text = "\(data?.prayerName ?? "") (\(newInterval))"
    }
}
