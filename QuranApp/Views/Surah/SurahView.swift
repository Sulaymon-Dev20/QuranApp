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
    @EnvironmentObject var routerManager: RouterManager
//    @EnvironmentObject var reviewsManager: ReviewsRequestManager
//    @Environment(\.requestReview) var requestReview: RequestReviewAction
    
    var body: some View {
        SurahListView(list: routerManager.sort ? filterData().reversed() : filterData())
            .viewTabToolbar(searchText: $routerManager.searchText,
                            title: routerManager.getNavigationTitle(),
                            navigationBarTrailing: routerManager.navigationBarTrailing())
            .onDisappear {
                routerManager.searchText = ""
            }
    }
    
    func filterData() -> [SurahModel] {
        if routerManager.searchText.count > 0 {
            return datas.items.filter {
                return LocalizedStringKey($0.title.localizedForm).stringValue().lowercased().contains(routerManager.searchText.lowercased())
            }
        } else {
            return datas.items
        }
    }
    
    struct SurahView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationStack {
                SurahView()
            }
            .environmentAllObject()
        }
    }
}

