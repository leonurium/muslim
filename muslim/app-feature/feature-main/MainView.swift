//
//  MainView.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import UIKit
import Foundation
import FirebaseCrashlytics
import SPPermissions

class MainView: UIViewController, MainPresenterToView {
    var presenter: MainViewToPresenter?
    
    @IBOutlet weak var tableview: UITableView!
    
    init() {
        super.init(nibName: String(describing: MainView.self), bundle: Bundle(for: MainView.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.didLoad()
    }
    
    func setupViews() {
        SPPermission.Dialog.requestIfNeeded(with: [.locationAlwaysAndWhenInUse], on: self, delegate: self, dataSource: self)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.tintColor  = UIMColor.white.get()
        
        let btn_info = UIBarButtonItem(image: UIImage(identifierName: .btn_info), style: .plain, target: self, action: #selector(didTapInfo))
        navigationItem.rightBarButtonItems = [btn_info]
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.separatorStyle = .none
        tableview.register(MainClockCell.source.nib, forCellReuseIdentifier: MainClockCell.source.identifier)
        tableview.register(MainTimeTableCell.source.nib, forCellReuseIdentifier: MainTimeTableCell.source.identifier)
        tableview.register(MainQiblaCell.source.nib, forCellReuseIdentifier: MainQiblaCell.source.identifier)
        
        let imageView = UIImageView()
        imageView.image = UIImage(identifierName: .image_background_2)
        tableview.backgroundView = imageView
    }
    
    func reloadTableView() {
        if let table = tableview {
            table.reloadData()
        }
    }
    
    func updateIntevalView(remaining: String) {
        if let cell = tableview.cellForRow(at: IndexPath(row: 0, section: 0)) as? MainClockCell {
            cell.updateIntervalView(newInterval: remaining)
        }
    }
    
    func updateQiblaView(angle: Double) {
        if let cell = tableview.cellForRow(at: IndexPath(row: 2, section: 0)) as? MainQiblaCell {
            cell.updateQibla(angle: angle)
        }
    }
    
    @objc
    func didTapInfo() {
        presenter?.navigateToInfo()
    }
}

extension MainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if
            indexPath.row == 0,
            let cell = tableView.dequeueReusableCell(withIdentifier: MainClockCell.source.identifier) as? MainClockCell {
            cell.data = presenter?.cellForRowClock()
            return cell
        }
        
        if
            indexPath.row == 1,
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTimeTableCell.source.identifier) as? MainTimeTableCell {
            cell.timeTable = presenter?.cellForRowTimeTable()
            cell.delegate = self
            return cell
        }
        
        if
            indexPath.row == 2,
            let cell = tableView.dequeueReusableCell(withIdentifier: MainQiblaCell.source.identifier) as? MainQiblaCell {
            cell.qibla = presenter?.cellForRowQibla()
            return cell
        }
        
        return UITableViewCell()
    }
}

extension MainView: MainTimeTableCellDelegate {
    func didTapItem(index: Int, cell: MainTimeTableCell) {
        debugLog(index)
    }
}

extension MainView: SPPermissionDialogDelegate {}

extension MainView: SPPermissionDialogDataSource {
    func description(for permission: SPPermissionType) -> String? {
        switch permission {
        case .locationWhenInUse : return infoPlist(key: .NSLocationUsageDescription)
        case .locationAlwaysAndWhenInUse : return infoPlist(key: .NSLocationAlwaysAndWhenInUseUsageDescription)
        default: return "Need Allow for use this Application"
        }
    }
}

extension MainView: AppLifecycleListener {
    func willResignActive() {
        debugLog(#function)
    }
    
    func didEnterBackground() {
        debugLog(#function)
    }
    
    func willEnterForeground() {
        self.reloadTableView()
        debugLog(#function)
    }
}

