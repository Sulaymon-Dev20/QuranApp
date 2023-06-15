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
                            Button {//qiladigan ishla bor
                                if item.active {
                                    noficationsManager.removeNotication(list: [item.id])
                                }
                                notificatSurahViewModel.deleteItem(id: item.id)
                            } label: {
                                Label("Delete", systemImage: "trash.slash.fill")
                            }
                            .tint(.red)
                        }
                        .overlay {
                            NavigationLink(value: Route.menu(item: item.page.intValue)) {
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
                        ListEmptyView(icon: "note", text: "notificationDoesNotExistYet")
                            .frame(maxWidth: .infinity)
                    })
                }
            } else {
                Button {
                    showAlert = true
                } label: {
                    ZStack {
                        PermissionDenied(img: "clock.badge.exclamationmark.fill", text: "notificationPermissionDenied")
                            .frame(maxWidth: .infinity)
                        AlertPermissions(showAlert: $showAlert, title: "notificationPermission", message: "allowNotificationToYsePlease")
                    }
                }
                .task {
                    noficationsManager.request()
                }
            }
        } header: {
            Text("notifications")
        }
        .task {
            noficationsManager.checkNotificationPermission()
            notificatSurahViewModel.checkStatus()
        }
    }
    
    func onchange(_ status:Bool, _ isActiveToggle:Bool, _ item: NotificatSurah) {
        if isActiveToggle {
//            notificatSurahViewModel.changeActive(id: item.id, time: item.time, active: status)f
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
        .environmentObject(RouterManager())
        //        .environment(\.locale, Locale.init(identifier: "ar"))
    }
}
