//
//  Route.swift
//  QuranApp
//
//  Created by Sulaymon on 24/05/23.
//

import Foundation

enum Route: Hashable {
    case menu(item: any Hashable)
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs:Route, rhs:Route) -> Bool {
        switch (lhs, rhs){
        case (.menu(let lhsItem),.menu(let rhsItem)):
            return lhsItem.hashValue == rhsItem.hashValue
        }
    }
}
