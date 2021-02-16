//
//  QiblaPresenter.swift
//  muslim
//
//  Created by Developer on 16/02/21.
//

import Foundation

class QiblaPresenter: QiblaViewToPresenter {
    weak var view: QiblaPresenterToView?
    var interactor: QiblaPresenterToInteractor?
    var router: QiblaPresenterToRouter?
    
    func didLoad() {
        view?.setupViews()
        interactor?.requestData()
    }
    
    func numberOfRowsInSection() -> Int {
        1
    }
    
    func cellForRowQibla() -> MainQibla? {
        return MainQibla(
            image_compass: Identifier.ImageName.image_compass_1.rawValue,
            image_qibla_direction: Identifier.ImageName.image_qibla_direction_1.rawValue
        )
    }
}

extension QiblaPresenter: QiblaInteractorToPresenter {
    func didGetQiblaDirection(angle: Double) {
        view?.dismissLoaderIndicator()
        view?.updateQiblaView(angle: angle)
    }
}
