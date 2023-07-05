//
//  NavigationRouter.swift
//  QuranApp
//
//  Created by Sulaymon on 23/05/23.
//

import SwiftUI

class RouterManager: ObservableObject {
    
    @Published var path = [Route]()
    @Published var tabValue: TabViewItemsModel? = TabViewItemsModel(id: 0, title: "surahs", icon: "book.circle", view: AnyView(SurahView()))
    @Published var tabBarHideStatus: Bool = false
    @Published var currentPDFPage: Int = 2
    
    @Published var searchText: String = ""
    @Published var sort: Bool = false
    
    let lastPageStorageKey:String = "uz.suyo.QuranApp.lastPageStorageKey"
    
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
                        self.getLastPage()
                    }
                }
            }
    }
    
    func getNavigationTitle() -> LocalizedStringKey {
        switch self.tabValue?.id {
        case 0:
            return "surahs"
        case 1:
            return "juz"
        default:
            return "bookmarks"
        }
    }
    
    func navigationBarTrailing() -> AnyView {
        let flag: Binding<Bool> = .init(get: { () -> Bool in
            return self.sort
        }, set: { (value) in
            self.sort = value
        })
        
        switch self.tabValue?.id {
        case 0:
            return AnyView(SortButtonView(sort: flag))
        case 1:
            return AnyView(SortButtonView(sort: flag))
        default:
            return AnyView(NecessaryButton())
        }
    }
    
    func pushTab(to item: Int) {
        switch item {
        case 0:
            self.tabValue = TabViewItemsModel(id: 0, title: "surahs", icon: "book.circle", view: AnyView(SurahView()));
        case 1:
            self.tabValue = TabViewItemsModel(id: 1, title: "juz", icon: "mountain.2.circle", view: AnyView(JuzView()));
        default:
            self.tabValue = TabViewItemsModel(id: 2, title: "bookmarks", icon: "bookmark.circle", view: AnyView(BookmarkView()))
        }
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
    
    func setCurrentPage(to pageNumber: Int) {
        self.currentPDFPage = pageNumber
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
