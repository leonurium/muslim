//
//  QuranView.swift
//  muslim
//
//  Created by Rangga Leo on 18/01/21.
//

import UIKit
import Foundation

class QuranView: UIViewController, QuranPresenterToView {
    var presenter: QuranViewToPresenter?
    
    @IBOutlet weak var tableView: UITableView!
    
    init() {
        super.init(nibName: String(describing: QuranView.self), bundle: Bundle(for: QuranView.self))
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
        tableView.register(QuranDefaultCell.source.nib, forCellReuseIdentifier: QuranDefaultCell.source.identifier)
        
        let imageView = UIImageView()
        imageView.image = UIImage(identifierName: .image_background_2)
        tableView.backgroundView = imageView
    }
    
    func showAlert(title: String, message: String, okCompletion: (() -> Void)?) {
        super.showAlert(title: title, message: message) { (act) in
            okCompletion?()
        }
    }
    
    func showAlertConfirm(title: String, message: String, okCompletion: (() -> Void)?, cancleCompletion: (() -> Void)?) {
        super.showAlertConfirm(title: title, message: message, OKCompletion: { (act) in
            okCompletion?()
        }) { (act) in
            cancleCompletion?()
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

extension QuranView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: QuranDefaultCell.source.identifier) as? QuranDefaultCell {
            cell.chapter = presenter?.cellForRowAt(indexPath: indexPath)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.navigateToVerse(indexPath: indexPath)
    }
}
