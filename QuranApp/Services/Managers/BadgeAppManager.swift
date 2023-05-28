//
//  BadgeAppManager.swift
//  QuranApp
//
//  Created by Sulaymon on 27/05/23.
//

import Foundation
import UIKit

class BadgeAppManager: ObservableObject {
    
    @Published private(set) var count:Int = UIApplication.shared.applicationIconBadgeNumber
                
    func minusBadge(number:Int) {
        self.count -= number
        UIApplication.shared.applicationIconBadgeNumber = self.count
    }

    func plusBadge(number:Int) {
        self.count += number
        UIApplication.shared.applicationIconBadgeNumber = self.count
    }
}
