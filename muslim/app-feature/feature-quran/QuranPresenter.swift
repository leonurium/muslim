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
        interactor?.getVerse(chapter_id: 2, verse_ids: [1,2,3,4,5,6,7,8,9])
//        interactor?.getChapter(chapter_id: nil)
    }
  
}

extension QuranPresenter: QuranInteractorToPresenter {
    func didGetQuran(chapters: [QuranManager.QuranChapter]) {
        if let verses = chapters.first?.verses {
            let text = verses.map({ $0.verse }).joined()
            DispatchQueue.main.async {
                self.view?.updateLabel(text: text)
            }
        }
    }
    
    func failGetQuran(title: String, error: String) {
        debugLog(error)
    }
}
