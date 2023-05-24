//
//  SurahListView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct SurahListView: View {
    
    let list: [SurahModel]
    
    @StateObject var noficationsViewModel = NoficationsManager()
    @EnvironmentObject var bookmarksViewModel: BookMarkViewModel

    @State var nativationStatus: Bool = false
    @State var nativationAlert: Bool = false
    
    var body: some View {
        if !list.isEmpty {
            List {
                ForEach(list, id: \.title){ item in
                    SurahRowView(number: (item.index as NSString).integerValue, name: item.title, type: item.type, verses: item.count, pageNumber: item.pages)
                        .overlay {
                            NavigationLink(value: Route.surah(item: item)) {
                                Text(">>>")
                            }
                            .opacity(0)
                        }
                        .alert(isPresented: $nativationAlert) {
                            Alert(
                                title: Text("Notication allow"),
                                message: Text("open and allow notification please"),
                                primaryButton: .destructive(Text("Cancel")),
                                secondaryButton: .default(
                                    Text("Allow"),
                                    action: {
                                        if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
                                            UIApplication.shared.open(appSettings)
                                        }
                                    }
                                )
                            )
                        }
                        .sheet(isPresented: $nativationStatus) {
                            SheetView(surah: item)
                        }
                        .swipeActions(edge: .trailing) {
                            let status = bookmarksViewModel.getPages().contains((item.pages as NSString).integerValue)
                            Button {
                                bookmarksViewModel.saveOrDelete(item: BookmarkModel(title: item.title, juz: item.juz[0].index, pageNumber: (item.pages as NSString).integerValue))
                            } label: {
                                Label("Choose", systemImage: status ? "bookmark.slash" : "bookmark")
                            }
                            .tint(status ? .red : .green)
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                Task {
                                    await noficationsViewModel.request()
                                }
                                if noficationsViewModel.hasPermission {
                                    nativationStatus.toggle()
                                } else {
                                    nativationAlert.toggle()
                                }
                            } label: {
                                Label("Choose", systemImage: noficationsViewModel.hasPermission ? nativationStatus ? "clock.badge.xmark" : "clock.badge.checkmark" : "clock.badge.xmark")
                            }
                            .tint(noficationsViewModel.hasPermission ? nativationStatus ?  .red : .green : .none)
                        }
                }
            }
        } else {
//            ListEmptyView()
        }
    }
}

struct SurahListView_Previews: PreviewProvider {
    static var previews: some View {
        SurahListView(list: [SurahModel(place: Place.mecca, type: TypeEnum.makkiyah, count: 22, title: "al_fatiha", titleAr: "String", index: "12", pages: "12", juz: [])])
            .environmentObject(BookMarkViewModel())
    }
}
