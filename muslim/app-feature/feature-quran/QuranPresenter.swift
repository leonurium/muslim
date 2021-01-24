//
//  QuranPresenter.swift
//  muslim
//
//  Created by Rangga Leo on 18/01/21.
//

import Foundation

class QuranPresenter: QuranViewToPresenter {
    weak var view: QuranPresenterToView?
    var interactor: QuranPresenterToInteractor?
    var router: QuranPresenterToRouter?
    
    private var surahs: [String] = []
    private var ayahs: [String] = []
    
    func didLoad() {
        interactor?.getQuran(surahNumber: nil, ayahNumber: [])
    }
  
}

extension QuranPresenter: QuranInteractorToPresenter {
    func didGetQuran(chapters: [QuranManager.QuranChapter]) {
        debugLog(chapters)
    }
    
    func failGetQuran(title: String, error: String) {
        debugLog(error)
    }
}
