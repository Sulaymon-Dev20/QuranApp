//
//  TabViewItemsModel.swift
//  QuranApp
//
//  Created by Sulaymon on 24/06/23.
//

import SwiftUI

struct TabViewItemsModel: Identifiable, Hashable, Equatable {
    let id: Int
    let title: LocalizedStringKey
    let icon: String
    let view: AnyView
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    public static func == (lhs: TabViewItemsModel, rhs: TabViewItemsModel) -> Bool {
        return lhs.id == rhs.id
    }
}

let tabViewItemsList: [TabViewItemsModel] = [
    TabViewItemsModel(id: 0, title: "surahs", icon: "book.circle", view: AnyView(SurahView())),
    TabViewItemsModel(id: 1, title: "juz", icon: "mountain.2.circle", view: AnyView(JuzView())),
    TabViewItemsModel(id: 2, title: "bookmarks", icon: "bookmark.circle", view: AnyView(BookmarkMainView()))
]
