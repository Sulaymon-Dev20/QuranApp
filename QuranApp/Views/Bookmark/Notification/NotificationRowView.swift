//
//  NotificationRowView.swift
//  QuranApp
//
//  Created by Sulaymon on 27/05/23.
//

import SwiftUI

struct NotificationRowView: View {
    @Binding var item: NotificatSurah
    
    let action: (_ status:Bool,_ activeToggle:Bool) -> Void
    
    var body: some View {
        HStack {
            Toggle(isOn: $item.isEveryDay) {
                if item.isEveryDay {
                    Image(systemName: "calendar")
                } else {
                    Text("\(item.time.day)")
                        .underline()
                }
            }
            .frame(maxWidth: 45)
            .onChange(of: item.active) { newValue in
                action(newValue, false)
            }
            .toggleStyle(.button)
            .tint(.blue)
            .disabled(!item.active)
            VStack(alignment: .leading) {
                Text(LocalizedStringKey(item.title.localizedForm))
                    .bold()
                Text(item.subTitle)
                    .font(.caption)
            }
            Spacer()
            HStack(alignment: .lastTextBaseline) {
                Toggle(isOn: $item.active) {
                    Text("\(item.time.clockString)")
                        .bold()
                        .strikethrough(!item.active)
                        .frame(width: 60, alignment: .center)
                }
                .onChange(of: item.active) { newValue in
                    action(newValue, true)
                }
            }
            .frame(width: 120, alignment: .leading)
        }
    }
}

struct NotificationRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            NotificationRowView(item: .constant(NotificatSurah(id: "idid", title: "surah Yasin", subTitle: "nimadir", url: "url", time: Date(), isEveryDay: true, active: true))) { item, status in
                
            }
            NotificationRowView(item: .constant(NotificatSurah(id: "idid", title: "surah Yasin", subTitle: "nimadir", url: "url", time: Date(), isEveryDay: false, active: true))) {
                print($0)
                print($1)
            }
            NotificationRowView(item: .constant(NotificatSurah(id: "idid", title: "surah Yasin", subTitle: "nimadir", url: "url", time: Date(), isEveryDay: true, active: false))) { item, status in
                
            }
            NotificationRowView(item: .constant(NotificatSurah(id: "idid", title: "surah Yasin", subTitle: "nimadir", url: "url", time: Date(), isEveryDay: false, active: false))) { item, status in
                
            }
        }
    }
}
