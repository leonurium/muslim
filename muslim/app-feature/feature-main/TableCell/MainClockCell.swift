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
    let placeName: String
}

class MainClockCell: UITableViewCell {
    
    @IBOutlet weak var container_view: UIStackView!
    @IBOutlet weak var lbl_time: UIMLabelTitle!
    @IBOutlet weak var lbl_remaining_time: UIMLabelBody!
    @IBOutlet weak var lbl_desc: UIMLabelTitle!
    
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
        lbl_desc.setFontSize(14)
        
        lbl_time.textColor = UIMColor.mine_shaft.get()
        lbl_remaining_time.textColor = UIMColor.mine_shaft.get()
        lbl_desc.textColor = UIMColor.mine_shaft.get()

        lbl_time.layer.masksToBounds = false
        lbl_remaining_time.layer.masksToBounds = false
        lbl_desc.layer.masksToBounds = false
    }
    
    private func updateUI() {
        lbl_time.text = data?.current
        lbl_remaining_time.text = "\(data?.prayerName ?? "") (\(data?.remaining ?? ""))"

        var place: String = ""
        place.append(CharacterConstant.pin_location.rawValue)
        place.append(" ")
        place.append(data?.placeName ?? "")
        lbl_desc.text = place.uppercased()
    }
    
    func updateIntervalView(newInterval: String) {
        lbl_remaining_time.text = "\(data?.prayerName ?? "") (\(newInterval))"
    }
}

class MaskableCellView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        let hole = CGRect(x: self.frame.minX + 16, y: self.frame.minY + 16, width: self.frame.width - 64, height: self.frame.height - 48)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = hole
        let roundedRectPath = UIBezierPath(roundedRect: hole, cornerRadius: 10)
        let path = UIBezierPath(rect: bounds)
        path.append(roundedRectPath)
        maskLayer.fillRule = .evenOdd
        maskLayer.path = path.cgPath        
        layer.mask = maskLayer
    }
}
