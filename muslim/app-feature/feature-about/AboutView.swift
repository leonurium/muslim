//
//  AboutView.swift
//  muslim
//
//  Created by Rangga Leo on 10/01/21.
//

import UIKit
import Foundation

class AboutView: UIViewController, AboutPresenterToView {
    var presenter: AboutViewToPresenter?
    
    @IBOutlet weak var lbl_content: UIMLabelBody!
    
    init() {
        super.init(nibName: String(describing: AboutView.self), bundle: Bundle(for: AboutView.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.didLoad()
    }
    
    func setupViews() {
        view.backgroundColor = UIMColor.mine_shaft.get()
        title = "About"
        lbl_content.numberOfLines = 0
        lbl_content.textAlignment = .justified
        lbl_content.textColor = UIMColor.white.get()
    }
    
    func updateContent(data: String) {
        lbl_content.text = data
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
