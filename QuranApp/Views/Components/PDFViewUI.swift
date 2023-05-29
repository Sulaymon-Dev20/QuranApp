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
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @State var pageNumber: Int
    @State var showTogBar: Bool = false
    
    var body: some View {
        PDFViewer(pageNumber: $pageNumber)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture(count: 2) {
//                that need to scoom out
            }
            .onTapGesture {
                showTogBar.toggle()
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(showTogBar ? .hidden : .visible, for: .navigationBar)
            .animation(Animation.easeInOut(duration: 0.9).delay(0.6), value: showTogBar)
            .toolbarBackground(.visible, for: .navigationBar)
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
                    Button {
                        bookmarksViewModel.saveOrDelete(item: getSurahByPage(page: pageNumber))
                    } label: {
                        Image(systemName: bookmarksViewModel.getPages().contains(pageNumber) ? "bookmark.slash.fill" : "bookmark.fill")
                    }
                }
            }
    }
    
    func getSurahByPage(page: Int) -> BookmarkModel {
        for item in datas.items.reversed() {
            if item.pages.intValue <= page {
                return BookmarkModel(title: item.title, juz: item.juz[0].index, pageNumber: page)
            }
        }
        return BookmarkModel(title: "??", juz: "??", pageNumber: 1)
    }
}

struct PDFViewUI_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PDFViewUI(pageNumber: 100)
        }
        .environmentObject(BookMarkViewModel())
        .environmentObject(RouterManager())
        .environmentObject(SurahViewModel())
    }
}
