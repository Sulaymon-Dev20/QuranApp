//
//  SurahView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI
import StoreKit
import CoreSpotlight
import MobileCoreServices

struct SurahView: View {
    @EnvironmentObject var datas: SurahViewModel
    @EnvironmentObject var routeManager: RouterManager
    @EnvironmentObject var reviewsManager: ReviewsRequestManager
    @EnvironmentObject var spotlightManager: SpotlightManager
    @Environment(\.requestReview) var requestReview: RequestReviewAction
    
    @State var searchText: String = ""
    @State var sort: Bool = false
    
    var body: some View {
        NavigationStack(path: $routeManager.path) {
            SurahListView(list: sort ? filterData().reversed() : filterData())
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("surahs")
                .toolbar(routeManager.tabBarHideStatus ? .hidden : .visible, for: .tabBar)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        LanguageButtonView()
                            .addSpotlight(0, shape: .rounded, roundedRadius: 10, text: "Lanuage Button \n you can chouse for lanugage")
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        SortButtonView(sort: $sort)
                            .addSpotlight(1, shape: .rounded, roundedRadius: 10, text: "For Sortitem Items for asc and deck")
                    }
                }
                .searchable(text: $searchText, placement: .toolbar, prompt: Text("search_surah"))
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .surah(let item):
                        switch item{
                        default:
                            PDFViewUI(pageNumber: (item as SurahModel).pages.intValue)
                        }
                    }
                }
        }
        .onAppear {
            if reviewsManager.canAskReview(increaseNum: true) {
                requestReview()
            }
        }
        .onDisappear {
            searchText = ""
        }
    }
    
    func filterData() -> [SurahModel] {
        if searchText.count > 0 {
            return datas.items.filter {
                return LocalizedStringKey($0.title.localizedForm).stringValue().lowercased().contains(searchText.lowercased())
            }
        } else {
            return datas.items
        }
    }
    
    struct SurahView_Previews: PreviewProvider {
        static var previews: some View {
            SurahView()
                .environmentObject(SurahViewModel())
                .environmentObject(BookMarkViewModel())
                .environmentObject(NotificatSurahViewModel())
                .environmentObject(LanguageViewModel())
                .environmentObject(RouterManager())
                .environmentObject(ReviewsRequestManager())
                .environmentObject(NoficationsManager())
                .environmentObject(SpotlightManager())
        }
    }
}

