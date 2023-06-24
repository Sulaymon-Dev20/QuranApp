//
//  SurahListView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI
import CoreSpotlight

struct SurahListView: View {
    
    let list: [SurahModel]
    
    @EnvironmentObject var noficationsManager: NoficationsManager
    @EnvironmentObject var bookmarksViewModel: BookMarkViewModel
    @EnvironmentObject var routerManager: RouterManager
    
    @State var nativationStatus: Bool = false
    @State var showAlert: Bool = false
    @State var index: SurahModel?
    
    var body: some View {
        if !list.isEmpty {
            ZStack {
                List (list, id: \.title) { item in
                    let status = bookmarksViewModel.getPages().contains((item.pages as NSString).integerValue)
                    VStack {
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            Button {
                                routerManager.setCurrentPage(to: item.pages.intValue)
                            } label: {
                                SurahRowView(number: (item.index as NSString).integerValue, name: item.title, type: item.type, verses: item.count, pageNumber: item.pages,status: status)
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                        } else {
                            SurahRowView(number: (item.index as NSString).integerValue, name: item.title, type: item.type, verses: item.count, pageNumber: item.pages,status: status)
                                .overlay {
                                    NavigationLink(value: Route.menu(item: item)) {
                                        Text(">>>")
                                    }
                                    .opacity(0)
                                }
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: !status) {
                        BookmarkSwipe(item: BookmarkModel(title: item.title, juz: item.juz[0].index, pageNumber: item.pages.intValue), status: status)
                            .tint(status ? .red : .green)
                    }
                    .swipeActions(edge: .leading) {
                        NotificationSwipe(nativationStatus: $nativationStatus, showAlert: $showAlert, index: item.index)
                            .task {
                                self.index = item
                                noficationsManager.checkNotificationPermission()
                                noficationsManager.request()
                            }
                        ShareSwipe(title: LocalizedStringKey(item.title).stringValue(), index: item.pages)
                    }
                }
                AlertPermissions(showAlert: $showAlert, title: "Location allow", message: "open and allow notification please")
            }
            .task {
                noficationsManager.checkNotificationPermission()
            }
            .sheet(isPresented: $nativationStatus) {
                SheetView(surah: index!)
            }
        } else {
            ItemNotFoundView()
        }
    }
}

struct SurahListView_Previews: PreviewProvider {
    static var previews: some View {
        SurahListView(list: [SurahModel(place: Place.mecca, type: TypeEnum.makkiyah, count: 22, title: "al_fatiha", titleAr: "String", index: "12", pages: "12", juz: [Juz(index: "asdf", verse: Verse(start: "12", end: "12"))])])
            .environmentObject(BookMarkViewModel())
            .environmentObject(NotificatSurahViewModel())
            .environmentObject(NoficationsManager())
            .environmentObject(RouterManager())
    }
}
