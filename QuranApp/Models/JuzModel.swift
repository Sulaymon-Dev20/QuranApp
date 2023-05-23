//
//  JuzModel.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import Foundation

// MARK: - JuzElement
struct JuzModel: Codable, Hashable {
    let index: Int
    let page: Int
    let surahs: [Surah]
}

// MARK: - Surah
struct Surah: Codable, Hashable {
    let titleAr, title: String
    let index: Int
    let verse: VerseNew
    let pageNumber: String
    let type: String
}

// MARK: - Verse
struct VerseNew: Codable, Hashable {
    let start, end: Int
}
