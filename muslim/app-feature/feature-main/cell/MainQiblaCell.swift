//
//  MainQiblaCell.swift
//  muslim
//
//  Created by Rangga Leo on 10/12/20.
//

import UIKit

class MainQiblaCell: UITableViewCell {
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        
    }
    
    private func updateUI() {
        
    }
}
