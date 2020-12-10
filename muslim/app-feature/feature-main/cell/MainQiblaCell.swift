//
//  MainQiblaCell.swift
//  muslim
//
//  Created by Rangga Leo on 10/12/20.
//

import UIKit

struct MainQibla {
    let image_compass: String
    let image_qibla_direction: String
}

protocol MainQiblaCellDelegate: class {
    
}

class MainQiblaCell: UITableViewCell {
    
    @IBOutlet weak var image_compass: UIImageView!
    @IBOutlet weak var image_qibla_direction: UIImageView!
    
    struct source {
        static var nib: UINib = UINib(nibName: String(describing: MainQiblaCell.self), bundle: Bundle(for: MainQiblaCell.self))
        static var identifier: String = String(describing: MainQiblaCell.self)
    }
    
    var qibla: MainQibla? {
        didSet {
            updateUI()
        }
    }
    
    weak var delegate: MainQiblaCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    private func updateUI() {
        image_compass.image = UIImage(named: qibla?.image_compass ?? "")
        image_qibla_direction.image = UIImage(named: qibla?.image_qibla_direction ?? "")
    }
    
    func updateQibla(angle: Double) {
        UIView.animate(withDuration: 0.5) {
            self.image_qibla_direction.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
        }
    }
}
