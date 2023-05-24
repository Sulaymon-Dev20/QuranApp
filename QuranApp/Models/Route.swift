//
//  Route.swift
//  QuranApp
//
//  Created by Sulaymon on 24/05/23.
//

import Foundation

enum Route: Hashable {
    case surah(item: SurahModel)
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs:Route, rhs:Route) -> Bool {
        switch (lhs, rhs){
        case (.surah(let lhsItem),.surah(let rhsItem)):
            return lhsItem.hashValue == rhsItem.hashValue
        }
    }
}
