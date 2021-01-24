//
//  QuranManager.swift
//  muslim
//
//  Created by Rangga Leo on 21/01/21.
//

import Foundation
import PrayerIDN

protocol QuranManagerDelegate: class {
    func didGetQuran(chapters: [QuranManager.QuranChapter])
    func failRequest(error: Error)
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
        var verses: [QuranVerse]
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
    private var quran: QuranIDN
    private var quranChapters: [QuranChapter] = []
    
    init() {
        quran = QuranIDN()
        quran.delegate = self
    }
    
    func getChapter(chapter_id: Int? = nil) {
        quran.getChapter(chapter_id: chapter_id)
    }
    
    func getVerse(chapter_id: Int, verse_ids: [Int]) {
        quran.getVerse(chapter_id: chapter_id, verse_ids: verse_ids, language: [.ar, .id, .en])
    }
    
    private func inputChapters(chap: QuranChapter) {
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

extension QuranManager: QuranIDNDelegate {
    func didGetVerse(chapter: QuranIDN.QuranChapter) {
        let chap = chapter.convert()
        inputChapters(chap: chap)
        delegate?.didGetQuran(chapters: quranChapters)
    }
    
    func didGetChapter(chapters: [QuranIDN.QuranChapter]) {
        let chaps = chapters.map({ $0.convert() })
        for chap in chaps {
            inputChapters(chap: chap)
        }
        delegate?.didGetQuran(chapters: quranChapters)
    }
    
    func failGetVerse(error: Error) {
        delegate?.failRequest(error: error)
    }
    
    func failGetChapter(error: Error) {
        delegate?.failRequest(error: error)
    }
}

extension QuranIDN.QuranChapter {
    func convert() -> QuranManager.QuranChapter {
        var verses: [QuranManager.QuranVerse] = []
        if self.verses.count > 0 {
            verses = self
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
        }
        
        return QuranManager.QuranChapter(id: self.id, name: self.name, nameArabic: self.nameArabic, place: self.place, verses_count: self.verses_count, verses: verses)
    }
}


