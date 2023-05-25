//
//  SheetView.swift
//  QuranApp
//
//  Created by Sulaymon on 23/05/23.
//

import SwiftUI

struct SheetView: View {
    @EnvironmentObject var notificatSurahViewModel: NotificatSurahViewModel
    @EnvironmentObject var noficationsManager: NoficationsManager
    @EnvironmentObject var prayerTimeViewModel: PrayerTimeManager
    @EnvironmentObject var locationManager: LocationManager
    
    @Environment(\.dismiss) var dismiss
    
    @State var date: Date = Date()
    @State var everyDay: Bool = false
    @State var location: Bool = true
    @State var showAlert: Bool = false
    
    let surah: SurahModel
    let calendar = Calendar.current
    
    var body: some View {
        let data = prayerTimeViewModel.getPrayTime(time: Date(), latitude: locationManager.location?.latitude ?? 0.0, longitude: locationManager.location?.longitude ?? 0.0)
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
            
            Text(date.clockString)
                .font(.largeTitle)
                .padding(.bottom,40)
            
            DatePicker("Natification time", selection: $date, displayedComponents: [.hourAndMinute])
            ZStack {
                VStack {
                    HStack {
                        Text("select mathhab to time ")
                        Spacer()
                        Picker("Vaqtini tanlang", selection: $prayerTimeViewModel.isHanafi, content: {
                            Text("hanafi")
                                .tag(true)
                            Text("shafi")
                                .tag(false)
                        })
                        .onChange(of: prayerTimeViewModel.isHanafi) { newValue in
                            prayerTimeViewModel.changeMashab(to: newValue)
                        }
                    }
                    Picker("Vaqtini tanlang", selection: pref, content: {
                        ForEach(0..<data.count, id: \.self) { index in
                            Text(data[index].name)
                                .tag(data[index].time)
                        }
                    })
                    .padding(.bottom,20)
                    .pickerStyle(SegmentedPickerStyle())
                    Button {
                        locationManager.request()
                    } label: {
                        HStack {
                            Image(systemName: "paperplane")
                            Text("Location update")
                        }
                    }
                }
                .blur(radius: locationManager.checkLocationPermission() ? 0 : 8)
                Button {
                    locationManager.getLocation()
                    showAlert = true
                } label: {
                    PermissionDenied(img: "paperplane.circle.fill", text: "Location Denited")
                        .frame(maxWidth: .infinity)
                }
                .opacity(locationManager.checkLocationPermission() ? 0 : 1)
            }
            AlertPermissions(showAlert: $showAlert, title: "Location allow", message: "open and allow notification please")
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
                    let item = NotificatSurah(id: surah.index, title: surah.title, subTitle: "", url: "surahs?index=\(surah.index)", time: self.date, isEveryDay: everyDay, active: true)
                    notificatSurahViewModel.saveOrDelete(item: item)
                    noficationsManager.pushNotication(item: item)
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
            .environmentObject(PrayerTimeManager())
            .environmentObject(LocationManager())
    }
}
