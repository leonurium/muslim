//
//  QiblaView.swift
//  muslim
//
//  Created by Developer on 16/02/21.
//

import UIKit
import Foundation

class QiblaView: UIViewController, QiblaPresenterToView {
    var presenter: QiblaViewToPresenter?
    
    @IBOutlet weak var tableView: UITableView!
    
    init() {
        super.init(nibName: String(describing: QiblaView.self), bundle: Bundle(for: QiblaView.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.didLoad()
    }
    
    func setupViews() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.tintColor  = UIMColor.white.get()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(MainQiblaCell.source.nib, forCellReuseIdentifier: MainQiblaCell.source.identifier)
    }
    
    func updateQiblaView(angle: Double) {
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? MainQiblaCell {
            cell.updateQibla(angle: angle)
        }
    }
}

extension QiblaView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if
            indexPath.row == 0,
            let cell = tableView.dequeueReusableCell(withIdentifier: MainQiblaCell.source.identifier) as? MainQiblaCell {
            cell.qibla = presenter?.cellForRowQibla()
            return cell
        }
        
        return UITableViewCell()
    }
}
