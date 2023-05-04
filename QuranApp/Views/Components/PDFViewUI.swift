//
//  PDFViewUI.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct PDFViewUI: View {

    @State var pageNumber: Int
    @State var permessionBookmarkButton: Bool = false
    @Binding var hiddenBar: Bool
    @EnvironmentObject var bookmarksViewModel: BookMarkViewModel
    @ObservedObject var datas = SurahViewModel()
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        GeometryReader { geometry in
            VStack {
                PDFViewer(pageNumber: $pageNumber)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.hiddenBar = false
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
                    if permessionBookmarkButton {
                        self.hiddenBar = false
                    }
                    bookmarksViewModel.saveOrDelete(item: getSurahByPage(page: pageNumber))
                } label: {
                    Image(systemName: bookmarksViewModel.getPages().contains(pageNumber) ? "bookmark.slash.fill" : "bookmark.fill")
                }
            }
        }
    }
    
    func getSurahByPage(page: Int) -> BookmarkModel {
        for item in datas.items.reversed() {
            if (item.pages as NSString).integerValue <= page {
                return BookmarkModel(title: item.title, juz: item.juz[0].index, pageNumber: page)
            }
        }
        return BookmarkModel(title: "??", juz: "??", pageNumber: 1)
    }
}

struct PDFViewUI_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PDFViewUI(pageNumber: 100, hiddenBar: .constant(true))
        }
        .environmentObject(BookMarkViewModel())
    }
}
