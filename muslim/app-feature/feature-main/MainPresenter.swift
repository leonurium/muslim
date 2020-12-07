//
//  MainPresenter.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import Foundation

class MainPresenter: MainViewToPresenter {
    weak var view: MainPresenterToView?
    var interactor: MainPresenterToInteractor?
    var router: MainPresenterToRouter?
    
    func didLoad() {
        view?.setupViews()
    }
    
    func numberOfRowsInSection() -> Int {
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) {
        
    }
}

extension MainPresenter: MainInteractorToPresenter {
    
}
