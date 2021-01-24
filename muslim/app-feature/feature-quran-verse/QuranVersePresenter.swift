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
  
}

extension QuranVersePresenter: QuranVerseInteractorToPresenter {
    
}
