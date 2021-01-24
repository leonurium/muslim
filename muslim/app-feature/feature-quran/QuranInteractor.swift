// 
//  QuranInteractor.swift
//  muslim
//
//  Created by Rangga Leo on 18/01/21.
//

import Foundation

class QuranInteractor: QuranPresenterToInteractor {
    weak var presenter: QuranInteractorToPresenter?
    
    func getQuran(surahNumber: Int? = nil, ayahNumber: [Int] = []) {
        let quran = QuranManager(surahNumber: surahNumber, ayahNumber: ayahNumber)
        quran.delegate = self
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
