//
//  ReviewsRequestManager.swift
//  QuranApp
//
//  Created by Sulaymon on 26/05/23.
//

import Foundation

class ReviewsRequestManager: ObservableObject {
    //    private(set) var reviewLink = URL(string: "https://apps.apple.com/app/idYourAppStoreId?action=write-review")
    private(set) var reviewLink = URL(string: "https://apps.apple.com/app/id6448216007?action=write-review")//test

    let storageKey = "reviewsRequestManager"
    let limit = 100

//    init() {
//        UserDefaults.standard.set(0, forKey: storageKey)
//    }
    
    func canAskReview(increaseNum: Bool = false) -> Bool {
        if increaseNum {
            increase()
        }
        let currentCount = UserDefaults.standard.integer(forKey: storageKey)
        print(currentCount)
        return currentCount == limit - 1
    }
    
    func increase() {
        let count = UserDefaults.standard.integer(forKey: storageKey)
        if count < limit {
            UserDefaults.standard.set(count + 1, forKey: storageKey)
        }
    }
}
