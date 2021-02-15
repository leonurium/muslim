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
        let permission = SPPermissions.dialog([.locationAlwaysAndWhenInUse])
        permission.delegate = self
        permission.dataSource = self
        permission.present(on: self)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.tintColor  = UIMColor.white.get()
        
        let btn_info = UIMButtonIcon()
        let btn_info_image = UIImage(identifierName: .btn_info)?.withRenderingMode(.alwaysTemplate)
        btn_info.setIcon(image: btn_info_image)
        btn_info.setInset()
        btn_info.setCornerRadius(radius: 5)
        btn_info.addTarget(self, action: #selector(didTapInfo), for: .touchUpInside)
        let btn_bar_info = UIBarButtonItem()
        btn_bar_info.customView = btn_info
        navigationItem.rightBarButtonItems = [btn_bar_info]
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.separatorStyle = .none
        tableview.isScrollEnabled = false
        tableview.register(MainClockCell.source.nib, forCellReuseIdentifier: MainClockCell.source.identifier)
        tableview.register(MainMenuCell.source.nib, forCellReuseIdentifier: MainMenuCell.source.identifier)
        tableview.register(MainTodayVerseCell.source.nib, forCellReuseIdentifier: MainTodayVerseCell.source.identifier)
        tableview.register(MainTimeTableCell.source.nib, forCellReuseIdentifier: MainTimeTableCell.source.identifier)
        tableview.register(MainQiblaCell.source.nib, forCellReuseIdentifier: MainQiblaCell.source.identifier)
        
        let imageView = UIImageView()
//        imageView.image = UIImage(identifierName: .image_background_2)
        tableview.backgroundView = imageView
    }
    
    func reloadTableView() {
        if let table = tableview {
            DispatchQueue.main.async {
                table.reloadData()
            }
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
    
    func updateTitle(title: String) {
        self.title = title
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
            let cell = tableView.dequeueReusableCell(withIdentifier: MainMenuCell.source.identifier) as? MainMenuCell {
            cell.menus = presenter?.cellForRowMainMenu() ?? []
            cell.delegate = self
            return cell
        }
        
        if
            indexPath.row == 2,
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTodayVerseCell.source.identifier) as? MainTodayVerseCell {
            cell.data = presenter?.cellForRowTodayVerse()
            cell.delegate = self
            return cell
        }
        
        if
            indexPath.row == 3,
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTimeTableCell.source.identifier) as? MainTimeTableCell {
            cell.timeTable = presenter?.cellForRowTimeTable()
            cell.delegate = self
            return cell
        }
        
        if
            indexPath.row == 4,
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

extension MainView: MainTodayVerseCellDelegate {
    func didTapShare(cell: MainTodayVerseCell) {
        var items: [Any] = []
        items.append(cell.data?.text ?? "")
        items.append(cell.data?.subText ?? "")
        let shareVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(shareVC, animated: true, completion: nil)
    }
}

extension MainView: MainMenuCellDelegate {
    func didTapMenu(item: MainMenuItem) {
        debugLog(item)
        switch item.type {
        case .quran : presenter?.navigateToQuran()
        case .qibla : presenter?.navigateToQibla()
        case .praytime : presenter?.navigateToPraytime()
        }
    }
}

extension MainView: SPPermissionsDelegate { }

extension MainView: SPPermissionsDataSource {
    func configure(_ cell: SPPermissionTableViewCell, for permission: SPPermission) -> SPPermissionTableViewCell {
        
        switch permission {
        
        case .locationWhenInUse :
            let description = infoPlist(key: .NSLocationUsageDescription)
            cell.permissionDescriptionLabel.text = description
            
        case .locationAlwaysAndWhenInUse :
            let description = infoPlist(key: .NSLocationAlwaysAndWhenInUseUsageDescription)
            cell.permissionDescriptionLabel.text = description
            
        default:
            let description = "Need Allow for use this Application"
            cell.permissionDescriptionLabel.text = description
        }
        
        return cell
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

