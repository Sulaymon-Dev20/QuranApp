//
//  SurahModel.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import Foundation

// MARK: - SurahElement
struct SurahModel:Codable, Hashable {
    let place: Place
    let type: TypeEnum
    let count: Int
    let title, titleAr, index, pages: String
    let juz: [Juz]
}

// MARK: - Juz
struct Juz: Codable, Hashable {
    let index: String
    let verse: Verse
}

// MARK: - Verse
struct Verse: Codable, Hashable {
    let start, end: String
}

enum Place: String, Codable {
    case mecca = "Mecca"
    case medina = "Medina"
}

enum TypeEnum: String, Codable {
    case madaniyah = "Madaniyah"
    case makkiyah = "Makkiyah"
}
