//
//  JuzModel.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import Foundation

// MARK: - JuzElement
struct JuzModel: Codable {
    let index: Int
    let page: Int
    let surahs: [Surah]
}

// MARK: - Surah
struct Surah: Codable {
    let titleAr, title: String
    let index: Int
    let verse: VerseNew
    let pageNumber: String
}

// MARK: - Verse
struct VerseNew: Codable {
    let start, end: Int
}
