//
//  NotificationRowView.swift
//  QuranApp
//
//  Created by Sulaymon on 27/05/23.
//

import SwiftUI

struct NotificationRowView: View {
    @EnvironmentObject var languageViewModel: LanguageViewModel
    
    @Binding var item: NotificatSurah
    
    let action: (_ activeToggle:Bool) -> Void
    
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
                action(false)
            }
            .toggleStyle(.button)
            .tint(.blue)
            .disabled(!item.active)
            Menu {
                NavigationLink(value: Route.menu(item: item.page.intValue)) {
                    Label("open", systemImage: "arrowshape.zigzag.right")
                }
                Button {
                    item.active = !item.active
                    action(true)
                } label: {
                    Label(item.active ? "disactive" : "active", systemImage: item.active ? "speaker.slash" : "speaker.wave.2.fill")
                }
                Button(role: .destructive) {
                    
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
                action(true)
            }
            .frame(width: 120, alignment: .leading)
        }
    }
}

struct NotificationRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            NotificationRowView(item: .constant(NotificatSurah(id: "idid", title: "surah Yasin", subTitle: "nimadir", url: "url", page: "12", time: Date(), isEveryDay: true, active: true))) { item in
                
            }
            NotificationRowView(item: .constant(NotificatSurah(id: "idid", title: "surah Yasin", subTitle: "nimadir", url: "url", page: "12", time: Date(), isEveryDay: false, active: true))) {
                print($0)
            }
            NotificationRowView(item: .constant(NotificatSurah(id: "idid", title: "surah Yasin", subTitle: "nimadir", url: "url", page: "12", time: Date(), isEveryDay: true, active: false))) { item in
                
            }
            NotificationRowView(item: .constant(NotificatSurah(id: "idid", title: "surah Yasin", subTitle: "nimadir nimadir nimadir nimadir nimadir nimadir nimadir nimadir nimadir nimadir nimadir nimadir nimadir", url: "url", page: "12", time: Date(), isEveryDay: false, active: false))) { item in
                
            }
        }
        .environmentObject(LanguageViewModel())
    }
}
