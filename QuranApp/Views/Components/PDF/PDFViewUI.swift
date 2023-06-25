//
//  PDFViewUI.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct PDFViewUI: View {
    
    @EnvironmentObject var bookmarksViewModel: BookMarkViewModel
    @EnvironmentObject var routerManager: RouterManager
    @EnvironmentObject var surahViewModel: SurahViewModel
    @EnvironmentObject var juzViewModel: JuzViewModel
    @EnvironmentObject var reviewsManager: ReviewsRequestManager
    
    @State var showTogBar: Bool = false
    
    var body: some View {
        let item = surahViewModel.getSurahByPage(routerManager.currentPDFPage)!
        PDFViewer(pageNumber: $routerManager.currentPDFPage)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture(count: 2) {
                // that need to scoom out
            }
            .onTapGesture {
                showTogBar.toggle()
            }
            .toolbar(showTogBar ? .hidden : .visible, for: .navigationBar)
            .animation(Animation.easeInOut(duration: 0.9).delay(0.6), value: showTogBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(LocalizedStringKey(item.title.localizedForm).stringValue()).bold()
                        Text("\("page".lv.capitalized) \(routerManager.currentPDFPage), \("juz".lv.capitalized) \(juzViewModel.getJuz(routerManager.currentPDFPage))")
                            .font(.caption2)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    BookmarkSwipe(item: BookmarkModel(title: item.title, juz: item.juz[0].index, pageNumber: routerManager.currentPDFPage), status: bookmarksViewModel.getPages().contains(routerManager.currentPDFPage))
                }
                ToolbarTitleMenu {
                    ForEach(surahViewModel.items, id: \.index) { surah in
                        Button {
                            routerManager.setCurrentPage(to: surah.pages.intValue)
                        } label: {
                            Label(LocalizedStringKey(surah.title.localizedForm), systemImage: surah.type == .madaniyah ? "moon.fill" : "sun.max.fill")
                        }
                        .disabled(surah.index == item.index)
                    }
                }
            }
            .onAppear {
                routerManager.tabBarHide(status: true)
                reviewsManager.increase()
            }
    }
}

struct PDFViewUI_Previews: PreviewProvider {
    static var previews: some View {
        NavigationSplitView {
            List {
                Text("asdf")
                Text("asdf")
                Text("asdf")
            }
        } detail: {
            PDFViewUI()
        }
        .environmentAllObject()
    }
}
