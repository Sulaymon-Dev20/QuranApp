//
//  BookmarkModel.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import Foundation

struct BookmarkModel: Codable, Identifiable, Hashable {
    var id = UUID()
    let title, juz: String
    let pageNumber: Int
    
    func toString() -> String {
        return title+"|"+juz+"|\(pageNumber)";
    }
}
