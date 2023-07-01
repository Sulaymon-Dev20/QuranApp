//
//  NotificationSwipe.swift
//  QuranApp
//
//  Created by Sulaymon on 01/06/23.
//

import SwiftUI

struct NotificationSwipe: View {
    @EnvironmentObject var noficationsManager: NotificationManager
    @EnvironmentObject var notificatSurahViewModel: NotificatSurahViewModel

    @Binding var nativationStatus: Bool
    @Binding var showAlert: Bool

    let index: String

    var body: some View {
        let isItemExist = notificatSurahViewModel.getIds().contains(index)
        let statusNotification = noficationsManager.hasPermission
        Button {
            if statusNotification {
                nativationStatus.toggle()
            } else {
                showAlert.toggle()
            }
        } label: {
            Label("Choose", systemImage: statusNotification ? isItemExist ? "clock.badge.xmark" : "clock.badge.checkmark" : "clock.badge.xmark")
        }
        .tint(statusNotification ? isItemExist ? .red : .green : .none)
    }
}

struct NotificationSwipe_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSwipe(nativationStatus: .constant(false), showAlert: .constant(false), index: "001")
            .environmentAllObject()
    }
}
