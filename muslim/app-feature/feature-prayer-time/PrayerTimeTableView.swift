//
//  PrayerTimeTableView.swift
//  muslim
//
//  Created by Developer on 16/02/21.
//

import UIKit
import Foundation

class PrayerTimeTableView: UIViewController, PrayerTimeTablePresenterToView {
    var presenter: PrayerTimeTableViewToPresenter?
    
    @IBOutlet weak var tableView: UITableView!
    
    init() {
        super.init(nibName: String(describing: PrayerTimeTableView.self), bundle: Bundle(for: PrayerTimeTableView.self))
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
        tableView.register(MainTimeTableCell.source.nib, forCellReuseIdentifier: MainTimeTableCell.source.identifier)
    }
    
    func reloadTableView() {
        if let table = tableView {
            DispatchQueue.main.async {
                table.reloadData()
            }
        }
    }
}

extension PrayerTimeTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if
            indexPath.row == 0,
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTimeTableCell.source.identifier) as? MainTimeTableCell {
            cell.timeTable = presenter?.cellForRowTimeTable()
            cell.delegate = self
            return cell
        }
        
        return UITableViewCell()
    }
}

extension PrayerTimeTableView: MainTimeTableCellDelegate {
    func didTapItem(index: Int, cell: MainTimeTableCell) {
        debugLog(index)
    }
}
