//
//  NotificatSurah.swift
//  QuranApp
//
//  Created by Sulaymon on 23/05/23.
//

import Foundation

struct NotificatSurah: Codable {
    let id: String
    let time: Date
    let title, juz: String
    let pageNumber: Int
    var isStatus: Bool = false
    
    func toString() -> String {
        return title+"|"+juz+"|\(pageNumber)"+"\(time)";
    }
}
