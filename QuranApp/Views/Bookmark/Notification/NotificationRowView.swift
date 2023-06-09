//
//  NotificationRowView.swift
//  QuranApp
//
//  Created by Sulaymon on 27/05/23.
//

import SwiftUI

struct NotificationRowView: View {
    @EnvironmentObject var languageViewModel: LanguageViewModel
    @EnvironmentObject var routerManager: RouterManager
    @EnvironmentObject var notificatSurahViewModel: NotificatSurahViewModel
    @EnvironmentObject var notificationsManager: NotificationManager

    @Binding var item: NotificatSurah
        
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
                if !newValue {
                    checkDate()
                }
                notificatSurahViewModel.changeStatus(id: item.id, isEveryDay: newValue)
                notificationsManager.removeNotication(list: [item.id])
                notificationsManager.pushNotication(item: item)
            }
            .toggleStyle(.button)
            .tint(.blue)
            .disabled(!item.active)
            Menu {
                NavigationLink(value: Route.menu(item: item.page.intValue)) {
                    Label("open", systemImage: "arrowshape.zigzag.right")
                }
                .hideIfPad()
                Button {
                    changeActiveStatus(!item.active)
                } label: {
                    Label(item.active ? "disactive" : "active", systemImage: item.active ? "speaker.slash" : "speaker.wave.2.fill")
                }
                Button(role: .destructive) {
                    notificationsManager.removeNotication(list: [item.id])
                    notificatSurahViewModel.deleteItem(id: item.id)
                } label: {
                    Label("delete", systemImage: "trash")
                }
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey(item.title.localizedForm))
                            .bold()
                        Text(LocalizedStringKey(item.subTitle))
                            .lineLimit(1)
                            .font(.caption)
                    }
                    Spacer()
                }
            }
            .buttonStyle(.plain)
            Toggle(isOn: $item.active) {
                Text(item.time.clockString.convertedDigitsToLocale(languageViewModel.language))
                    .bold()
                    .strikethrough(!item.active)
                    .frame(width: 60, alignment: .center)
            }
            .onChange(of: item.active) { newValue in
                changeActiveStatus(newValue)
            }
            .frame(width: 120, alignment: .leading)
        }
    }
    
    func changeActiveStatus(_ newValue:Bool) {
        item.active = newValue
        notificatSurahViewModel.changeActive(id: item.id, time: item.time, active: !item.active)
        if newValue {
            checkDate()
            notificationsManager.pushNotication(item: item)
        } else {
            notificationsManager.removeNotication(list: [item.id])
        }
    }
    
    func checkDate() {
        if item.time.isExpired() {
            item.time.updateDayTomerrow()
        }
    }
}

struct NotificationRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            NotificationRowView(item: .constant(NotificatSurah(id: "idid", title: "surah Yasin", subTitle: "nimadir", url: "url", page: "12", time: Date(), isEveryDay: true, active: true)))
            NotificationRowView(item: .constant(NotificatSurah(id: "idid", title: "surah Yasin", subTitle: "nimadir", url: "url", page: "12", time: Date(), isEveryDay: false, active: true)))
            NotificationRowView(item: .constant(NotificatSurah(id: "idid", title: "surah Yasin", subTitle: "nimadir", url: "url", page: "12", time: Date(), isEveryDay: true, active: false)))
            NotificationRowView(item: .constant(NotificatSurah(id: "idid", title: "surah Yasin", subTitle: "nimadir nimadir nimadir nimadir nimadir nimadir nimadir nimadir nimadir nimadir nimadir nimadir nimadir", url: "url", page: "12", time: Date(), isEveryDay: false, active: false)))
        }
        .environmentAllObject()
    }
}
