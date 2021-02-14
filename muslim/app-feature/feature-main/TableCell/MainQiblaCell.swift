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
    
    private lazy var line_view: UIView = {
        $0.backgroundColor = UIMColor.white.get()
        return $0
    }(UIView())
    
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
        image_compass.image = UIImage(named: qibla?.image_compass ?? "")?.withRenderingMode(.alwaysTemplate)
        image_qibla_direction.image = UIImage(named: qibla?.image_qibla_direction ?? "")?.withRenderingMode(.alwaysTemplate)
        
        image_compass.tintColor = UIMColor.mine_shaft.get()
        image_qibla_direction.tintColor = UIMColor.mine_shaft.get()
    }
    
    func updateQibla(angle: Double) {
        let decimal = Double(round(100*angle)/100)
        if decimal <= 0.01 && decimal >= -0.01 {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            
            contentView.addSubview(line_view)
            contentView.bringSubviewToFront(line_view)
            line_view.translatesAutoresizingMaskIntoConstraints = false
            line_view.topAnchor.constraint(equalTo: image_compass.topAnchor).isActive = true
            line_view.bottomAnchor.constraint(equalTo: image_qibla_direction.topAnchor, constant: 5).isActive = true
            line_view.centerXAnchor.constraint(equalTo: image_compass.centerXAnchor).isActive = true
            line_view.widthAnchor.constraint(equalToConstant: 2).isActive = true
            
        } else {
            line_view.removeFromSuperview()
        }
        
        UIView.animate(withDuration: 0.5) {
            self.image_qibla_direction.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
        }
    }
}
