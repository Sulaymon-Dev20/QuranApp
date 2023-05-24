//
//  NavigationRouter.swift
//  QuranApp
//
//  Created by Sulaymon on 23/05/23.
//

import Foundation

class NavigationRouter: ObservableObject {
    
    @Published var path = [Route]()

    func gotoHomePage() {
        path.removeLast(path.count)
    }

    func push(to item: Route) {
        if !path.contains(item) {
            path.append(item)
        }
    }

    func tapOnSecondPage() {
        path.removeLast()
    }
}
