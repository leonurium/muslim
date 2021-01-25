// 
//  QuranInteractor.swift
//  muslim
//
//  Created by Rangga Leo on 18/01/21.
//

import Foundation

class QuranInteractor: QuranPresenterToInteractor {
    weak var presenter: QuranInteractorToPresenter?
    private var quran: QuranManager
    
    init() {
        quran = QuranManager()
        quran.delegate = self
    }
    
    func getChapter(chapter_id: Int?) {
        quran.getChapter(chapter_id: chapter_id)
    }
}

extension QuranInteractor: QuranManagerDelegate {
    func didGetQuran(chapters: [QuranManager.QuranChapter]) {
        presenter?.didGetQuran(chapters: chapters)
    }
    
    func failRequest(error: Error) {
        presenter?.failGetQuran(title: LTitleAlert.error.localized, error: error.localizedDescription)
    }
}
