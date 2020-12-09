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
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.separatorStyle = .none
        tableview.register(MainClockCell.source.nib, forCellReuseIdentifier: MainClockCell.source.identifier)
        
        let imageView = UIImageView()
        imageView.image = UIImage(identifierName: .image_background_2)
        tableview.backgroundView = imageView
    }
    
    func reloadTableView() {
        tableview.reloadData()
    }
    
    func updateIntevalView(remaining: String) {
        if let cell = tableview.cellForRow(at: IndexPath(row: 0, section: 0)) as? MainClockCell {
            cell.updateIntervalView(newInterval: remaining)
        }
    }
}

extension MainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MainClockCell.source.identifier) as? MainClockCell {
            cell.data = presenter?.cellForRowClock()
            return cell
        }
        return UITableViewCell()
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

