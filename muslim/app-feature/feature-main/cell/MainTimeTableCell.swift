//
//  MainTimeTableCell.swift
//  muslim
//
//  Created by Rangga Leo on 09/12/20.
//

import UIKit

struct MainTimeTablePrayerAndTimes {
    let prayer: MuslimPrayer
    let time: Date
}

struct MainTimeTable {
    let prayers: [MainTimeTablePrayerAndTimes]
    let currentPrayer: MuslimPrayer
}

protocol MainTimeTableCellDelegate: class {
    func didTapItem(index: Int, cell: MainTimeTableCell)
}

class MainTimeTableCell: UITableViewCell {
    
    @IBOutlet weak var container_round: UIView!
    @IBOutlet weak var container_view: UIStackView!
    
    struct source {
        static var nib: UINib = UINib(nibName: String(describing: MainTimeTableCell.self), bundle: Bundle(for: MainTimeTableCell.self))
        static var identifier: String = String(describing: MainTimeTableCell.self)
    }
    
    var timeTable: MainTimeTable? {
        didSet {
            updateUI()
        }
    }
    
    weak var delegate: MainTimeTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
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
        container_round.backgroundColor = UIMColor.mine_shaft.get().withAlphaComponent(0.3)
        container_round.backgroundColor = .clear
        
        container_view.backgroundColor = .clear
        container_view.spacing = 8
        container_view.distribution = .fill
    }
    
    private func updateUI() {
        guard let main = timeTable else { return }
        
        if container_view.arrangedSubviews.count >= main.prayers.count {
            return
        }
        
        for prayer in main.prayers {
            guard let index = main.prayers.firstIndex(where: { String(describing: $0.prayer) == String(describing: prayer.prayer) }) else { return }
            
            let lbl_prayer = UIMLabelBody()
            lbl_prayer.text = String(describing: prayer.prayer).capitalized
            lbl_prayer.textColor = UIMColor.white.get()
            lbl_prayer.setFontSize(18)
            lbl_prayer.textAlignment = .left
            lbl_prayer.tag = index
            lbl_prayer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemClicked(_:))))
            
            let lbl_time = UIMLabelBody()
            lbl_time.textColor = UIMColor.white.get()
            lbl_time.setFontSize(18)
            lbl_time.textAlignment = .right
            lbl_time.tag = index
            lbl_time.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemClicked(_:))))
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            lbl_time.text = formatter.string(from: prayer.time)
            
            let stack = UIStackView()
            stack.spacing = 8
            stack.distribution = .fillProportionally
            stack.axis = .horizontal
            stack.backgroundColor = .clear
            
            if prayer.prayer == main.currentPrayer {
                lbl_prayer.makeBold()
                lbl_time.makeBold()
                stack.backgroundColor = UIMColor.white.get().withAlphaComponent(0.4)
                stack.layer.cornerRadius = 10
            }
            
            let view = UIView()
            view.backgroundColor = .clear
            let view2 = UIView()
            view2.backgroundColor = .clear
            
            stack.addArrangedSubview(view)
            stack.addArrangedSubview(lbl_prayer)
            stack.addArrangedSubview(lbl_time)
            stack.addArrangedSubview(view2)
            
            container_view.addArrangedSubview(stack)
        }
    }
    
    @objc private func itemClicked(_ sender: UIView) {
        delegate?.didTapItem(index: sender.tag, cell: self)
    }
}
