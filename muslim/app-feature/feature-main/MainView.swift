//
//  MainView.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import UIKit
import Foundation
import FirebaseCrashlytics

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
        navigationController?.navigationBar.isHidden = false
        tableview.dataSource = self
        tableview.delegate = self
    }
}

extension MainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
