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
    @EnvironmentObject var notificatSurahViewModel: NotificatSurahViewModel
    
    @State var nativationStatus: Bool = false
    @State var showAlert: Bool = false
    @State var index: SurahModel?
    
    var body: some View {
        if !list.isEmpty {
            ZStack{
                List {
                    ForEach(Array(list.enumerated()), id: \.offset) { index, item in
                        let status = bookmarksViewModel.getPages().contains((item.pages as NSString).integerValue)
                        ZStack {
                            if index == 0 {
                                SurahRowView(number: (item.index as NSString).integerValue, name: item.title, type: item.type, verses: item.count, pageNumber: item.pages)
                                    .addSpotlight(2, shape: .rounded, roundedRadius: 10, text: "Item Item")
                            } else {
                                SurahRowView(number: (item.index as NSString).integerValue, name: item.title, type: item.type, verses: item.count, pageNumber: item.pages)
                            }
                        }
                        .overlay {
                            NavigationLink(value: Route.surah(item: item)) {
                                Text(">>>")
                            }
                            .opacity(0)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: !status) {
                            Button {
                                bookmarksViewModel.saveOrDelete(item: BookmarkModel(title: item.title, juz: item.juz[0].index, pageNumber: (item.pages as NSString).integerValue))
                            } label: {
                                Label("Choose", systemImage: status ? "bookmark.slash" : "bookmark")
                            }
                            .tint(status ? .red : .green)
                        }
                        .swipeActions(edge: .leading) {
                            let isItemExist = notificatSurahViewModel.getIds().contains(item.index)
                            let statusNotification = noficationsManager.hasPermission
                            Button {
                                Task {
                                    await noficationsManager.request()
                                }
                                if statusNotification {
                                    nativationStatus.toggle()
                                } else {
                                    showAlert.toggle()
                                }
                            } label: {
                                Label("Choose", systemImage: statusNotification ? isItemExist ? "clock.badge.xmark" : "clock.badge.checkmark" : "clock.badge.xmark")
                            }
                            .tint(statusNotification ? isItemExist ? .red : .green : .none)
                            .task {
                                self.index = item
                                noficationsManager.checkNotificationPermission()
                            }
                            let title = LocalizedStringKey(item.title).stringValue()
                            ShareLink(item: title, subject: Text(item.title), message: Text("holyquran://surahs?index=\(item.index)"), preview: SharePreview(title, icon: "link.circle.fill")) {
                                Label("ShareLink", systemImage:  "link.circle.fill")
                            }
                            .tint(.blue)
                        }
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
        SurahListView(list: [SurahModel(place: Place.mecca, type: TypeEnum.makkiyah, count: 22, title: "al_fatiha", titleAr: "String", index: "12", pages: "12", juz: [])])
            .environmentObject(BookMarkViewModel())
            .environmentObject(NotificatSurahViewModel())
            .environmentObject(NoficationsManager())
    }
}
