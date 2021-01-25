//
//  QuranVerseView.swift
//  muslim
//
//  Created by Rangga Leo on 24/01/21.
//

import UIKit
import Foundation

class QuranVerseView: UIViewController, QuranVersePresenterToView {
    var presenter: QuranVerseViewToPresenter?
    
    @IBOutlet weak var tableView: UITableView!
    
    init() {
        super.init(nibName: String(describing: QuranVerseView.self), bundle: Bundle(for: QuranVerseView.self))
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
        tableView.register(QuranVerseDefaultCell.source.nib, forCellReuseIdentifier: QuranVerseDefaultCell.source.identifier)
        
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
        super.showAlertConfirm(title: title, message: message) { (act) in
            okCompletion?()
        } CancelCompletion: { (act) in
            cancleCompletion?()
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

extension QuranVerseView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: QuranVerseDefaultCell.source.identifier) as? QuranVerseDefaultCell {
            cell.verse = presenter?.cellForRowAt(indexPath: indexPath)
            return cell
        }
        
        return UITableViewCell()
    }
}
