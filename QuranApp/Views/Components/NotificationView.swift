//
//  NotificationView.swift
//  QuranApp
//
//  Created by Sulaymon on 25/05/23.
//

import SwiftUI

struct NotificationView: View {
    @EnvironmentObject var noficationsManager: NoficationsManager
    @EnvironmentObject var notificatSurahViewModel: NotificatSurahViewModel
    
    var body: some View {
        let show = noficationsManager.hasPermission
        Section("Notifications") {
            ZStack {
                VStack {
                    if !notificatSurahViewModel.items.isEmpty {
                        ForEach($notificatSurahViewModel.items, id: \.id) { $item in
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                Toggle(isOn: $item.active) {
                                    Text(LocalizedStringKey(item.title.localizedForm))
                                    Text("remain time \(item.time.clockString)")
                                }
                                .onChange(of: item.active) { value in
                                    notificatSurahViewModel.changeStatus(id: item.id, active: value)
                                    if value {
                                        noficationsManager.pushNotication(item: item)
                                    } else {
                                        noficationsManager.removeNotication(list: [item.id])
                                    }
                                }
                            }
                            .contextMenu {
                                Label("delete", systemImage: "trash.circle")
                                Label("share", systemImage: "square.and.arrow.up.circle")
                            } preview: {
                                Text("you can delete and do sth")
                                    .padding()
                            }
                        }
                        .onDelete(perform: notificatSurahViewModel.deleteItem)
                    } else {
                        BookmarkEmptyView()
                    }
                }
                .blur(radius: show ? 0 : 8)
                PermissionDenied(img: "clock.badge.exclamationmark.fill", text: "Notification Permission Denited")
                    .opacity(show ? 0 : 1)
            }
//            .onTapGesture(count:2, perform: {
//
//            })
            .frame(maxWidth: .infinity)
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NotificationView()
        }
        .environmentObject(NoficationsManager())
        .environmentObject(NotificatSurahViewModel())
    }
}
