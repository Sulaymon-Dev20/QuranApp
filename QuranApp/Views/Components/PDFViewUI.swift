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
    @EnvironmentObject var datas: SurahViewModel
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @State var showTogBar: Bool = false
    
    var body: some View {
        let item = getSurahByPage(page: routerManager.currentPDFPage)!
        PDFViewer(pageNumber: $routerManager.currentPDFPage)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture(count: 2) {
                // that need to scoom out
            }
            .onTapGesture {
                showTogBar.toggle()
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(showTogBar ? .hidden : .visible, for: .navigationBar)
            .animation(Animation.easeInOut(duration: 0.9).delay(0.6), value: showTogBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle(LocalizedStringKey(item.title.localizedForm).stringValue())
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        routerManager.tabBarHide(status: false)
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("back")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    BookmarkSwipe(item: BookmarkModel(title: item.title, juz: item.juz[0].index, pageNumber: routerManager.currentPDFPage), status: bookmarksViewModel.getPages().contains(routerManager.currentPDFPage))
                }
                ToolbarTitleMenu {
                    ForEach(datas.items, id: \.index) { surah in
                        Button {
                            routerManager.currentPDFPage = surah.pages.intValue
                        } label: {
                            Label(LocalizedStringKey(surah.title.localizedForm), systemImage: surah.type == .madaniyah ? "moon.fill" : "sun.max.fill")
                        }
                        .disabled(surah.index == item.index)
                    }
                }
            }
            .onAppear {
                routerManager.tabBarHide(status: true)
            }
    }
    
    func getSurahByPage(page: Int) -> SurahModel? {
        for item in datas.items.reversed() {
            if item.pages.intValue <= page {
                return item
            }
        }
        return nil
    }
}

struct PDFViewUI_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PDFViewUI()
                .navigationBarTitleDisplayMode(.inline)
        }
        .environmentObject(BookMarkViewModel())
        .environmentObject(RouterManager())
        .environmentObject(SurahViewModel())
    }
}
