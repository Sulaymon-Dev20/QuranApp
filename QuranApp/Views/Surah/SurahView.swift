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
    @Environment(\.requestReview) var requestReview: RequestReviewAction

    @State var searchText: String = ""
    @State var sort: Bool = false
    @State var degree: Double = 0
    
    func additem() {
        let attributeSet = CSSearchableItemAttributeSet(contentType: .content)
        attributeSet.title = "surah Yasin"
        attributeSet.contentDescription = "surah Yasin"
        attributeSet.relatedUniqueIdentifier = "starWar"
        attributeSet.identifier = "starWar"

        attributeSet.addedDate = Date()

        let searchableItem = CSSearchableItem(uniqueIdentifier: "starWar", domainIdentifier: "surah", attributeSet: attributeSet)

        CSSearchableIndex.default()
            .indexSearchableItems([searchableItem]) { error in
                    if let error = error {
                        print("Error indexing: \(error)")
                    } else {
                        print("Indexed.")
                    }
            }
    }
        
    var body: some View {
        NavigationStack(path: $routeManager.path) {
            SurahListView(list: sort ? filterData().reversed() : filterData())
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("surahs")
                .toolbar(routeManager.tabBarHideStatus ? .hidden : .visible, for: .tabBar)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        LanguageButtonView()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation {
                                self.sort = !sort
                                degree += 180
                            }
                        } label: {
                            Image(systemName: "arrow.up")
                                .rotationEffect(.degrees(degree))
                                .animation(.linear(duration: 0.3), value: sort)
                        }
                    }
                }
                .searchable(text: $searchText, placement: .toolbar, prompt: Text("search_surah"))
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .surah(let item):
                        switch item{
                        default:
                            PDFViewUI(pageNumber: (item as SurahModel).pages.intValue)
                                .onAppear {
                                    routeManager.tabBarHide(status: true)
                                }
                        }
                    }
                }
        }
        .onAppear {
            if reviewsManager.canAskReview(increaseNum: true) {
                requestReview()
            }
            additem()
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
        }
    }
}

