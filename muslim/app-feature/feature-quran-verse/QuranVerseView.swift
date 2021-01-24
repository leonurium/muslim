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
    
    init() {
        super.init(nibName: String(describing: QuranVerseView.self), bundle: Bundle(for: QuranVerseView.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
