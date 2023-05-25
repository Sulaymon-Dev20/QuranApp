//
//  NotificatSurah.swift
//  QuranApp
//
//  Created by Sulaymon on 23/05/23.
//

import Foundation

struct NotificatSurah: Codable {
    let id, title, subTitle, url: String
    let time: Date
    var isEveryDay: Bool = false
    var active: Bool = true
}
