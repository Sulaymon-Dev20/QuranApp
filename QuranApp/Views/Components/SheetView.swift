//
//  SheetView.swift
//  QuranApp
//
//  Created by Sulaymon on 23/05/23.
//

import SwiftUI
//import _CoreLocationUI_SwiftUI

struct SheetView: View {
    @EnvironmentObject var notificatSurahViewModel: NotificatSurahViewModel
    //    @StateObject var locationViewModel = LocationViewModel()
    
    @StateObject var noficationsManager = NoficationsManager()
    @StateObject var prayerTimeViewModel = PrayerTimeManager()
    
    @State var date: Date = Date()
    @State var everyDay: Bool = false
    @State var location: Bool = true
    @State var showAlert: Bool = false
    @State var mashab: Int = 2
    
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
            Text("Natification Settings")
                .bold()
                .font(.title)
            
            Text("\(calendar.component(.hour, from: date)): \(calendar.component(.minute, from: date))")
                .font(.largeTitle)
                .padding(.bottom,40)
            
            DatePicker(surah.title, selection: $date, displayedComponents: [.hourAndMinute])
            HStack{
                Picker("Vaqtini tanlang", selection: $mashab, content: {
                    Text("shafi")
                        .tag(1)
                    Text("hanafi")
                        .tag(2)
                })
                
                Picker("Vaqtini tanlang", selection: pref, content: {
                    ForEach(0..<data.count, id: \.self) { index in
                        Text(data[index].name)
                            .foregroundColor(Color.white)
                            .tag(data[index].time)
                    }
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
                    noficationsManager.pushNotication(
                        id: surah.index,
                        title: surah.title,
                        subtitle: "Alert Shuncaki Takrorlashingiz kerak",
                        url: "surahs?index=\(surah.index)",
                        repeats: everyDay,
                        date: date
                    )
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
    }
}
