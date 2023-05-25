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
        ZStack {
            VStack {
                if !notificatSurahViewModel.items.isEmpty {
                    ForEach($notificatSurahViewModel.items, id: \.id) { $item in
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
                    .onDelete(perform: notificatSurahViewModel.deleteItem)
                } else {
                    BookmarkEmptyView()
                }
            }
            .blur(radius: noficationsManager.hasPermission ? 0 : 8)
            PermissionDenied(img: "clock.badge.exclamationmark.fill", text: "Notification Permission Denited")
                .opacity(noficationsManager.hasPermission ? 0 : 1)
        }
        .frame(maxWidth: .infinity)
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            NotificationView()
                .environmentObject(NoficationsManager())
                .environmentObject(NotificatSurahViewModel())
        }
    }
}
