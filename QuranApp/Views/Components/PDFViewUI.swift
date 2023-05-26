//
//  PDFViewUI.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct PDFViewUI: View {
    
    @State var pageNumber: Int
    @EnvironmentObject var bookmarksViewModel: BookMarkViewModel
    @EnvironmentObject var routerManager: RouterManager
    @EnvironmentObject var datas: SurahViewModel

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        GeometryReader { geometry in
            VStack {
                PDFViewer(pageNumber: $pageNumber)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .navigationBarBackButtonHidden(true)
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
