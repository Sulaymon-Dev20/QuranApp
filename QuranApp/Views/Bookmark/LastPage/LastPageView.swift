//
//  LastPageView.swift
//  QuranApp
//
//  Created by Sulaymon on 13/06/23.
//

import SwiftUI

struct LastPageView: View {
    @EnvironmentObject var routerManager: RouterManager
    @EnvironmentObject var surahViewModel: SurahViewModel
    
    var body: some View {
        let item = surahViewModel.getSurahByPage(routerManager.currentPDFPage)!
        Section("lastReadPage") {
            BookmarkRowView(title: item.title, juz: item.juz[0].index, pageNumber: routerManager.currentPDFPage)
                .overlay {
                    NavigationLink(value: Route.menu(item: routerManager.currentPDFPage.toString)) {
                        Text(">>>")
                    }
                    .opacity(0)
                }
        }
    }
}

struct LastPageView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            LastPageView()
        }
        .environmentObject(LanguageViewModel())
        .environmentObject(RouterManager())
        .environmentObject(SurahViewModel())
    }
}
