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
    
    @IBOutlet weak var lbl_body: UIMLabelBody!
    
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
    
    func updateLabel(text: String) {
        lbl_body.text = text
    }
}
