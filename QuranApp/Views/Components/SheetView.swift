//
//  SheetView.swift
//  QuranApp
//
//  Created by Sulaymon on 23/05/23.
//

import SwiftUI
import Adhan

struct SheetView: View {
    @EnvironmentObject var notificatSurahViewModel: NotificatSurahViewModel
    @EnvironmentObject var noficationsManager: NoficationsManager

    @Environment(\.dismiss) var dismiss
    //    @StateObject var locationViewModel = LocationViewModel()
    
    @StateObject var prayerTimeViewModel = PrayerTimeManager()
    
    @State var date: Date = Date()
    @State var everyDay: Bool = false
    @State var location: Bool = true
    @State var showAlert: Bool = false
    @State var mashab: Madhab = .hanafi
    
    let surah: SurahModel
    let calendar = Calendar.current
    
    var body: some View {
        let data = prayerTimeViewModel.getPrayTime(time: Date(), madhab: mashab)
        
        let pref = Binding<Date>(
            get: {
                date
            },
            set: {
                if location {
                    date = $0
                } else {
                    showAlert.toggle()
                }
            }
        )
        
        VStack{
            Text(surah.title)
                .bold()
                .font(.title)
            
            Text("\(calendar.component(.hour, from: date)): \(calendar.component(.minute, from: date))")
                .font(.largeTitle)
                .padding(.bottom,40)
            
            DatePicker("Natification time", selection: $date, displayedComponents: [.hourAndMinute])
            HStack {
                Text("select mathhab to time ")
                Spacer()
                Picker("Vaqtini tanlang", selection: $mashab, content: {
                    Text("hanafi")
                        .tag(Madhab.hanafi)
                    Text("shafi")
                        .tag(Madhab.shafi)
                })
            }
            Picker("Vaqtini tanlang", selection: pref, content: {
                ForEach(0..<data.count, id: \.self) { index in
                    Text(data[index].name)
                        .tag(data[index].time)
                }
            })
            .padding(.bottom,20)
            .pickerStyle(SegmentedPickerStyle())
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Notication allow"),
                    message: Text("open and allow notification please"),
                    primaryButton: .destructive(Text("Cancel")),
                    secondaryButton: .default(
                        Text("Allow"),
                        action: {
                            print("asdf")
                        }
                    )
                )
            }
            Toggle("Har kuni", isOn: $everyDay)
            Spacer()
            HStack{
                Button {
                    dismiss()
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
                    print(surah.index)
                    print("--------")
                    let item = NotificatSurah(id: surah.index, time: self.date, title: surah.title, juz: surah.juz[0].index, pageNumber: (surah.pages as NSString).integerValue)
                    notificatSurahViewModel.saveOrDelete(item: item)
                    noficationsManager.pushNotication(
                        id: surah.index,
                        title: surah.title,
                        subtitle: "Alert Shuncaki Takrorlashingiz kerak",
                        url: "surahs?index=\(surah.index)",
                        repeats: everyDay,
                        date: date
                    )
                    dismiss()
                } label: {
                    Text("Save")
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
        SheetView(surah: SurahModel(place: Place.mecca, type: TypeEnum.madaniyah, count: 12, title: "Surah Yasin", titleAr: "String", index: "1", pages: "1", juz: []))
    }
}
