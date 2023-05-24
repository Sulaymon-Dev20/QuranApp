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
    @StateObject var noficationsViewModel = NoficationsViewModel()
    @StateObject var prayerTimeViewModel = PrayerTimeViewModel()
    
    @State var date: Date = Date()
    @State var everyDay: Bool = false
    @State var location: Bool = false
    @State var showAlert: Bool = false
    
    let surah: SurahModel
    let calendar = Calendar.current
    
    var body: some View {
        let data = prayerTimeViewModel.getPrayTime(time: Date(), madhab: .hanafi)
        
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
            
            Picker("Vaqtini tanlang", selection: pref, content: {
                ForEach(0..<data.count, id: \.self) { index in
                    Text(data[index].name)
                        .tag(data[index].time)
                }
            })
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
            .padding(.bottom,20)
            .pickerStyle(SegmentedPickerStyle())
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
