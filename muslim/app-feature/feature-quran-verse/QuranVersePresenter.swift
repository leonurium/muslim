//
//  QuranVersePresenter.swift
//  muslim
//
//  Created by Rangga Leo on 24/01/21.
//

import Foundation

class QuranVersePresenter: QuranVerseViewToPresenter {
    weak var view: QuranVersePresenterToView?
    var interactor: QuranVersePresenterToInteractor?
    var router: QuranVersePresenterToRouter?
    var chapter_id: Int
    
    private var quranVerses: [QuranManager.QuranVerse] = []
    private var verse_ids: [Int] = []
    
    init(chapter_id: Int, verse_ids: [Int]) {
        self.chapter_id = chapter_id
        self.verse_ids = verse_ids
    }
    
    func didLoad() {
        view?.setupViews()
        view?.showLoaderIndicator()
        interactor?.getVerse(chapter_id: chapter_id, verse_ids: verse_ids)
    }
    
    func numberOfRowsInSection() -> Int {
        quranVerses.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> QuranManager.QuranVerse {
        quranVerses[indexPath.row]
    }
}

extension QuranVersePresenter: QuranVerseInteractorToPresenter {
    func didGetQuran(verses: [QuranManager.QuranVerse]) {
        for verse in verses {
            if !quranVerses.contains(verse) {
                quranVerses.append(verse)
            }
        }
        DispatchQueue.main.async {
            self.view?.dismissLoaderIndicator()
            self.view?.reloadTableView()
        }
    }
    
    func failGetQuran(title: String, error: String) {
        DispatchQueue.main.async {
            self.view?.dismissLoaderIndicator()
            self.view?.showAlert(title: title, message: error, okCompletion: nil)
        }
    }
}
