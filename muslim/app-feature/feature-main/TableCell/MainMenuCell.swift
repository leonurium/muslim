//
//  MainMenuCell.swift
//  muslim
//
//  Created by Rangga Leo on 14/02/21.
//

import UIKit

protocol MainMenuCellDelegate: class {
    func didTapMenu(item: MainMenuItem)
}

class MainMenuCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    struct source {
        static var nib: UINib = UINib(nibName: String(describing: MainMenuCell.self), bundle: Bundle(for: MainMenuCell.self))
        static var identifier: String = String(describing: MainMenuCell.self)
    }
    
    var menus: [MainMenuItem] = [] {
        didSet {
            updateUI()
        }
    }
    
    weak var delegate: MainMenuCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        collectionView.backgroundColor = .clear
        
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MainMenuItemCell.source.nib, forCellWithReuseIdentifier: MainMenuItemCell.source.identifier)
    }
    
    private func updateUI() {
        collectionView.reloadData()
    }
}

extension MainMenuCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainMenuItemCell.source.identifier, for: indexPath) as? MainMenuItemCell {
            cell.item = menus[indexPath.row]
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MainMenuCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let cellCount = collectionView.numberOfItems(inSection: 0)
        let totalCellWidth = 80 * cellCount
        let totalSpacingWidth = 8 * (cellCount - 1)
        
        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 2, left: leftInset, bottom: 2, right: rightInset)
    }
}

extension MainMenuCell: MainMenuItemCellDelegate {
    func didTapMenu(item: MainMenuItem) {
        delegate?.didTapMenu(item: item)
    }
}
