//
//  MainClockCell.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import UIKit

class MainClockCell: UITableViewCell {
    
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var lbl_remaining_time: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
//    @IBOutlet weak var lbl_pray: UILabel!
    
    struct source {
        static var nib: UINib = UINib(nibName: String(describing: MainClockCell.self), bundle: Bundle(for: MainClockCell.self))
        static var identifier: String = String(describing: MainClockCell.self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        selectionStyle = .none
    }
    
    private func updateUI() {
        
    }
}
