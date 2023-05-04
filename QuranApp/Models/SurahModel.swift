//
//  SurahModel.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import Foundation

// MARK: - SurahElement
struct SurahModel: Codable {
    let place: Place
    let type: TypeEnum
    let count: Int
    let title, titleAr, index, pages: String
    let juz: [Juz]
    
    func toString() -> String {
        return title+"|"+titleAr+"|"+index+"|\(type)"
    }
}

// MARK: - Juz
struct Juz: Codable {
    let index: String
    let verse: Verse
}

// MARK: - Verse
struct Verse: Codable {
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
