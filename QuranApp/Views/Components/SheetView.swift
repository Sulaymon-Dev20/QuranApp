//
//  SheetView.swift
//  QuranApp
//
//  Created by Sulaymon on 23/05/23.
//

import SwiftUI

struct SheetView: View {

    @EnvironmentObject var notificatSurahViewModel: NotificatSurahViewModel
    @StateObject var noficationsViewModel = NoficationsViewModel()

    @State var date:Date = Date()
    @State var selection = "Off"
    @State var onlyToday: Bool = true
    @State var everyDay: Bool = false

    let surah: SurahModel
    let calendar = Calendar.current

    var body: some View {
        VStack{
            Text("Natification Settings")
                .bold()
                .font(.title)
            Text("\(calendar.component(.hour, from: date)): \(calendar.component(.minute, from: date))")
                .font(.largeTitle)
                .padding(.bottom,40)
            DatePicker(surah.title, selection: $date,displayedComponents: [.hourAndMinute])
            Picker("Vaqtini tanlang", selection: $selection, content: {
                Text("\(calendar.component(.hour, from: date)): \(calendar.component(.minute, from: date))")
                    .tag("Off")
                Text("Bomdod")
                    .tag("bomdod")
                Text("Peshin")
                    .tag("peshin")
                Text("Asr")
                    .tag("asr")
                Text("Shom")
                    .tag("shom")
                Text("Hufton")
                    .tag("hufton")
            })
            .padding(.bottom,20)
            .pickerStyle(SegmentedPickerStyle())
            Toggle("Faqat bir kun", isOn: $onlyToday)
            Toggle("Har kuni", isOn: $everyDay)
            Spacer()
            HStack{
                Button {
                    
                } label: {
                    Text("cancel")
                        .bold()
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                }
                Spacer()
                Button {
                    let item = NotificatSurah(time: self.date, title: surah.title, juz: surah.juz[0].index, pageNumber: (surah.pages as NSString).integerValue)
                    notificatSurahViewModel.saveOrDelete(item: item)
                    noficationsViewModel.pushNotication()
                } label: {
                    Text("Add")
                        .bold()
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                }
            }
        }
        .padding()
        .presentationDetents([.medium, .large])
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(surah: SurahModel(place: Place.mecca, type: TypeEnum.madaniyah, count: 12, title: "asdf", titleAr: "String", index: "1", pages: "1", juz: []))
            .environmentObject(NoficationsViewModel())
    }
}
