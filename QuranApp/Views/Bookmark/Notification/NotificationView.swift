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
    @EnvironmentObject var routerManager: RouterManager
    @EnvironmentObject var badgeAppManager: BadgeAppManager

    @State var showAlert:Bool = false

    var body: some View {
        let show = noficationsManager.hasPermission
        Section {
            if show {
                if !notificatSurahViewModel.items.isEmpty {
                    ForEach($notificatSurahViewModel.items, id: \.id) { $item in
                        NotificationRowView(item: $item) { status, activeToggle in
                            onchange(status, activeToggle, item)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                notificatSurahViewModel.deleteItem(id: item.id)
//                                noficationsManager.removeNotication(list: [item.id])//bug
                            } label: {
                                Label("Delete", systemImage: "trash.slash.fill")
                            }
                            .tint(.red)
                        }
                        .overlay {
                            NavigationLink(value: item.page.intValue) {
                                Text(">>>")
                            }
                            .opacity(0)
                        }
                    }
                    .onMove(perform: notificatSurahViewModel.moveItem)
                } else {
                    Button(action: {
                        routerManager.pushTab(to: 0)
                    }, label: {
                        ListEmptyView(icon: "note", text: "notification doesn`t exist yet")
                            .frame(maxWidth: .infinity)
                    })
                }
            } else {
                Button {
                    showAlert = true
                } label: {
                    ZStack {
                        PermissionDenied(img: "clock.badge.exclamationmark.fill", text: "Notification Permission Denited")
                            .frame(maxWidth: .infinity)
                        AlertPermissions(showAlert: $showAlert, title: "Location allow", message: "open and allow notification please")
                    }
                }
                .task {
                    await noficationsManager.request()
                }
            }
        } header: {
            Text("Notifications")
        }
        .task {
            noficationsManager.checkNotificationPermission()
            notificatSurahViewModel.checkStatus()
        }
    }

    func onchange(_ status:Bool, _ activeToggle:Bool, _ item: NotificatSurah) {
        if activeToggle {
            notificatSurahViewModel.changeActive(id: item.id, time: item.time, active: status)
            if status {
                noficationsManager.pushNotication(item: item, badgeCount: badgeAppManager.count)
            } else {
                noficationsManager.removeNotication(list: [item.id])
            }
        } else {
            notificatSurahViewModel.changeStatus(id: item.id, active: status)
            noficationsManager.pushNotication(item: item, badgeCount: badgeAppManager.count)
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
        .environmentObject(RouterManager())
        .environmentObject(BadgeAppManager())
    }
}
