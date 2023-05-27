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
                            } label: {
                                Label("Delete", systemImage: "trash.slash.fill")
                            }
                            .tint(.red)
                        }
                    }
                    .onMove(perform: notificatSurahViewModel.moveItem)
                } else {
                    ListEmptyView(icon: "String", text: "")
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
            }
        } header: {
            Text("Notifications")
        }
        .task {
            noficationsManager.checkNotificationPermission()
        }
    }

    func onchange(_ status:Bool,_ activeToggle:Bool,_ item: NotificatSurah) {
        if activeToggle {
            notificatSurahViewModel.changeActive(id: item.id, active: status)
            if status {
                noficationsManager.pushNotication(item: item)
            } else {
                noficationsManager.removeNotication(list: [item.id])
            }
        } else {
            notificatSurahViewModel.changeStatus(id: item.id, active: status)
            noficationsManager.pushNotication(item: item)
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
