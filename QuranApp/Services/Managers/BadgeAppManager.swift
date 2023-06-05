//
//  BadgeAppManager.swift
//  QuranApp
//
//  Created by Sulaymon on 04/06/23.
//

import Foundation
import UIKit

class BadgeAppManager: ObservableObject {
    
    @Published private(set) var count:Int = UIApplication.shared.applicationIconBadgeNumber
    
    func update() {
        count = UIApplication.shared.applicationIconBadgeNumber
    }

    func minusBadge(number:Int) {
        update()
        UIApplication.shared.applicationIconBadgeNumber -= number
    }

    func plusBadge(number:Int) {
        update()
        UIApplication.shared.applicationIconBadgeNumber += number
    }

    func setBadge(number:Int) {
        update()
        UIApplication.shared.applicationIconBadgeNumber = number
    }
}
