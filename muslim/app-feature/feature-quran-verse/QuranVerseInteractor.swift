// 
//  QuranVerseInteractor.swift
//  muslim
//
//  Created by Rangga Leo on 24/01/21.
//

import Foundation

class QuranVerseInteractor: QuranVersePresenterToInteractor {
    weak var presenter: QuranVerseInteractorToPresenter?
    
    private var quran: QuranManager
    private var chapter_id: Int = 0
    
    init() {
        quran = QuranManager()
        quran.delegate = self
    }
    
    func getVerse(chapter_id: Int, verse_ids: [Int]) {
        self.chapter_id = chapter_id
        quran.getVerse(chapter_id: chapter_id, verse_ids: verse_ids)
    }
}

extension QuranVerseInteractor: QuranManagerDelegate {
    func didGetQuran(chapters: [QuranManager.QuranChapter]) {
        if let chapter = chapters.first(where: { $0.id == chapter_id }) {
            presenter?.didGetQuran(verses: chapter.verses)
        }
    }
    
    func failRequest(error: Error) {
        presenter?.failGetQuran(title: LTitleAlert.error.localized, error: error.localizedDescription)
    }
}
