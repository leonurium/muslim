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
    private var verse_count: Int
    private var loadMore: Bool = false
    
    init(chapter_id: Int, verse_count: Int) {
        self.chapter_id = chapter_id
        self.verse_count = verse_count
    }
    
    func didLoad() {
        view?.setupViews()
        let verse_ids = Array(1...IntConstant.maximum_request_verse.rawValue)
        interactor?.getVerse(chapter_id: chapter_id, verse_ids: verse_ids)
    }
    
    func numberOfRowsInSection() -> Int {
        quranVerses.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> QuranManager.QuranVerse {
        quranVerses[indexPath.row]
    }
    
    func requestVerse() {
        let start = quranVerses.count + 1
        let end = quranVerses.count + IntConstant.maximum_request_verse.rawValue
        let verse_ids = Array(start...end)
        if start < verse_count && loadMore {
            loadMore = false
            interactor?.getVerse(chapter_id: chapter_id, verse_ids: verse_ids)
        }
    }
}

extension QuranVersePresenter: QuranVerseInteractorToPresenter {
    func didGetQuran(verses: [QuranManager.QuranVerse]) {
        quranVerses.removeAll()
        quranVerses.append(contentsOf: verses)
        loadMore = true
        DispatchQueue.main.async {
            self.view?.reloadTableView()
        }
    }
    
    func failGetQuran(title: String, error: String) {
        loadMore = true
        DispatchQueue.main.async {
            self.view?.showAlert(title: title, message: error, okCompletion: nil)
        }
    }
}
