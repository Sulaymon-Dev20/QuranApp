//
//  NavigationRouter.swift
//  QuranApp
//
//  Created by Sulaymon on 23/05/23.
//

import Foundation
import SwiftUI

class RouterManager: ObservableObject {
    
    @Published var path = [Route]()
    @Published var tabValue: Int = 0
    @Published var tabBarHideStatus: Bool = false
    @Published var currentPDFPage: Int = 2
    
    let lastPageStorageKey:String = "lastPageStorageKey"
    
    let view = PDFViewUI()
    
    init() {
        getLastPage()
    }
    
    func push(to item: Route) {
        path.append(item)
    }
    
    func navigationDestination(_ route: Route) -> some View {
        return view
            .onAppear {
                switch route {
                case Route.menu(let item):
                    switch item{
                    case let pageNumber as Int:
                        self.currentPDFPage = pageNumber
                    case let pageNumberString as String:
                        self.currentPDFPage = pageNumberString.intValue
                    case let surahModel as SurahModel:
                        self.currentPDFPage = surahModel.pages.intValue
                    case let bookmarkModel as BookmarkModel:
                        self.currentPDFPage = bookmarkModel.pageNumber
                    default:
                        self.currentPDFPage = 1
                    }
                }
            }
    }
    
    func pushTab(to item: Int) {
        tabValue = item
    }
    
    func tabBarHide(status: Bool) {
        UserDefaults.standard.set(currentPDFPage, forKey: lastPageStorageKey)
        tabBarHideStatus = status
    }
    
    func getPage(url: URL) -> Int {
        let host = url.host()
        switch host {
        case "surahs":
            return 0
        case "juz":
            return 1
        case "bookmark":
            return 2
        default:
            return 0
        }
    }
    
    func getLastPage() {
        let lastPage = UserDefaults.standard.integer(forKey: lastPageStorageKey)
        if lastPage != 0 {
            self.currentPDFPage = lastPage
        }
    }
}

extension RouterManager {
    func pushDeepLink(to url: URL, list items: [SurahModel]) {
        pushTab(to: getPage(url: url))
        let queryParams = url.queryParameters
        if let indexQueryVal = queryParams?["index"] as? String {
            if path.isEmpty {
                push(to: Route.menu(item: indexQueryVal.intValue))
            } else {
                currentPDFPage = indexQueryVal.intValue
            }
        }
        if queryParams?["notification"] as? Bool ?? false {
            UIApplication.shared.applicationIconBadgeNumber -= 1
        }
    }
}
