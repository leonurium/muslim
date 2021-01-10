//
//  AboutPresenter.swift
//  muslim
//
//  Created by Rangga Leo on 10/01/21.
//

import Foundation

class AboutPresenter: AboutViewToPresenter {
    weak var view: AboutPresenterToView?
    var interactor: AboutPresenterToInteractor?
    var router: AboutPresenterToRouter?
    
    func didLoad() {
        view?.setupViews()
        view?.updateContent(data: "Muslimify is open source, aims to make Muslim life better. We really value the security and privacy of our users, we only use user data for application functionality. You can audit the quality of the program code, there may be hidden data collection. You can do a thorough audit at https://github.com/ranggaleoo/muslim. If you have any questions or suggestions about Muslimify, do not hesitate to contact me at ranggaleo@icloud.com")
    }
  
}

extension AboutPresenter: AboutInteractorToPresenter {
    
}
