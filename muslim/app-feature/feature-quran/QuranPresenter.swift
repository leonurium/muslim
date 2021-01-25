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
    
    private var quranChapters: [QuranManager.QuranChapter] = []
    
    func didLoad() {
        view?.setupViews()
        view?.showLoaderIndicator()
        interactor?.getChapter(chapter_id: nil)
    }
    
    func numberOfRowsInSection() -> Int {
        quranChapters.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> QuranManager.QuranChapter {
        quranChapters[indexPath.row]
    }
    
    func navigateToVerse(indexPath: IndexPath) {
        let chapter = quranChapters[indexPath.row]
        router?.navigateToVerse(chapter_id: chapter.id, verse_count: chapter.verses_count, from: view)
    }
    
    private func inputChapters(chap: QuranManager.QuranChapter) {
        if quranChapters.contains(chap),
           let index = quranChapters.firstIndex(of: chap) {
            
            for verse in chap.verses {
                if !quranChapters[index].verses.contains(verse) {
                    quranChapters[index].verses.append(verse)
                }
            }
            
        } else {
            quranChapters.append(chap)
        }
    }
}

extension QuranPresenter: QuranInteractorToPresenter {
    func didGetQuran(chapters: [QuranManager.QuranChapter]) {
        for chapter in chapters {
            inputChapters(chap: chapter)
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
