//
//  NotificatSurah.swift
//  QuranApp
//
//  Created by Sulaymon on 23/05/23.
//

import Foundation

struct NotificatSurah: Codable {
    var id, title, subTitle, url, page: String
    var time: Date
    var isEveryDay: Bool = false
    var active: Bool = true
}
