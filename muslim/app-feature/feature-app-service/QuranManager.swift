//
//  QuranManager.swift
//  muslim
//
//  Created by Rangga Leo on 21/01/21.
//

import Foundation
import PrayerIDN

protocol QuranManagerDelegate: class {
    func failRequest(error: Error)
    func didGetQuran(chapters: [QuranManager.QuranChapter])
}

class QuranManager {
    struct QuranChapter: Equatable {
        static func == (lhs: QuranManager.QuranChapter, rhs: QuranManager.QuranChapter) -> Bool {
            lhs.id == rhs.id
        }
        
        let id: Int
        let name: String
        let nameArabic: String
        let place: String
        let verses_count: Int
        let verses: [QuranVerse]
    }
    
    struct QuranVerse: Equatable {
        static func == (lhs: QuranManager.QuranVerse, rhs: QuranManager.QuranVerse) -> Bool {
            lhs.id == rhs.id
        }
        
        let id: Int
        let chapter_id: Int
        let verse: String
        let verse_locale: QuranVerseLanguage
    }
    
    struct QuranVerseLanguage {
        let indonesia: String?
        let english: String?
        let arabic: String?
    }
    
    weak var delegate: QuranManagerDelegate?
    
    init(surahNumber: Int? = nil, ayahNumber: [Int] = []) {
        let quran = QuranIDN(surahNumber: surahNumber, ayahNumber: ayahNumber, language: [.ar, .id, .en])
        quran.delegate = self
    }
}

extension QuranManager: QuranIDNDelegate {
    func failRequest(error: Error) {
        delegate?.failRequest(error: error)
    }
    
    func didGetQuran(result: [QuranIDN.QuranChapter]) {
        let chapters = result.map({ $0.convert() })
        debugLog(chapters)
        delegate?.didGetQuran(chapters: chapters)
    }
}

extension QuranIDN.QuranChapter {
    func convert() -> QuranManager.QuranChapter {
        let verses: [QuranManager.QuranVerse] = self
            .verses
            .map({
                let lang = QuranManager
                    .QuranVerseLanguage(
                        indonesia: $0.verse_locale.indonesia,
                        english: $0.verse_locale.english,
                        arabic: $0.verse_locale.arabic
                    )
                return QuranManager
                    .QuranVerse(
                        id: $0.id,
                        chapter_id: $0.chapter_id,
                        verse: $0.verse,
                        verse_locale: lang
                    )
            })
        
        return QuranManager.QuranChapter(id: self.id, name: self.name, nameArabic: self.nameArabic, place: self.place, verses_count: self.verses_count, verses: verses)
    }
}


