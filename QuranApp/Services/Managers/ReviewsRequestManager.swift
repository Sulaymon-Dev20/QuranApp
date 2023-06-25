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
    @Published var count:Int = 0

    let storageKey = "uz.suyo.QuranApp.reviewsRequestManager"
    let limit = 30

    init() {
        getCurrentValue()
    }
    
    func canAskReview(increaseNum: Bool = false) -> Bool {
        getCurrentValue()
        if increaseNum {
            increase()
        }
        return count == limit - 1
    }
    
    func increase() {
        if count < limit {
            UserDefaults.standard.set(count + 1, forKey: storageKey)
        }
        getCurrentValue()
    }
    
    func getCurrentValue() {
        self.count = UserDefaults.standard.integer(forKey: storageKey)
    }
}
