//
//  NavigationRouter.swift
//  QuranApp
//
//  Created by Sulaymon on 23/05/23.
//

import Foundation

class RouterManager: ObservableObject {
    
    @Published var path = [Route]()
    @Published var tabValue: Int = 0
    @Published var tabBarHideStatus: Bool = false

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
    
    func pushTab(to item: Int) {
        tabValue = item
    }
    
    func tabBarHide(status: Bool) {
        tabBarHideStatus = status
    }
}
