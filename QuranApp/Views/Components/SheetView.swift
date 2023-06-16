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
    @EnvironmentObject var languageViewModel: LanguageViewModel

    @Environment(\.dismiss) var dismiss
    
    @State var date: Date = Date()
    @State var everyDay: Bool = true
    @State var showAlert: Bool = false
    
    let surah: SurahModel
    
    var body: some View {
        let location = locationManager.location
        let data = prayerTimeViewModel.prayTimes
        let show = locationManager.checkLocationPermission()
        let loading = locationManager.loading
        VStack {
            Text(LocalizedStringKey(surah.title.localizedForm))
                .bold()
                .font(.title)
                .padding(.top, 40)

            Text(date.clockString.convertedDigitsToLocale(languageViewModel.language))
                .font(.largeTitle)
                .padding(.bottom,40)
            
            DatePicker("notificationTime", selection: $date, displayedComponents: [.hourAndMinute])
            ZStack {
                VStack {
                    HStack {
                        Text("selectMadhabToCorrectPrayIime")
                        Spacer()
                        Picker("", selection: $prayerTimeViewModel.isHanafi, content: {
                            Text("hanafi")
                                .tag(true)
                            Text("shafi")
                                .tag(false)
                        })
                        .onChange(of: prayerTimeViewModel.isHanafi) { newValue in
                            prayerTimeViewModel.changeMashab(to: newValue)
                        }
                    }
                    Picker("", selection: $date, content: {
                        ForEach(0..<data.count, id: \.self) { index in
                            Text(LocalizedStringKey(data[index].name))
                                .tag(data[index].time)
                        }
                    })
                    .onAppear {
                        date = data[0].time
                    }
                    .padding(.bottom,20)
                    .pickerStyle(SegmentedPickerStyle())
                    Button {
                        locationManager.request()
                    } label: {
                        HStack {
                            Image(systemName: "paperplane")
                            Text("locationUpdate")
                        }
                    }
                }
                .blur(radius: show && !loading ? 0 : 8)
                Button {
                    locationManager.getLocation()
                    if !show {
                        showAlert = true
                    }
                } label: {
                    PermissionDenied(img: "paperplane.circle.fill", text: "Location Denited")
                        .frame(maxWidth: .infinity)
                }
                .opacity(show ? 0 : 1)
                ProgressView()
                    .opacity(loading ? 1 : 0)
            }
            AlertPermissions(showAlert: $showAlert, title: "locationPermission", message: "allowLocationToUsePlease")
            Toggle("everyDay", isOn: $everyDay)
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
                    date.changeDay(day: date.intValue > Date().intValue ? date.day : date.day + 1)
                    let item = NotificatSurah(
                        id: UUID().uuidString,
                        title: surah.title,
                        subTitle: surah.type == .makkiyah ? "makkiyah" : "madaniyah",
                        url: "surahs?index=\(surah.pages)",
                        page: surah.pages,
                        time: self.date,
                        isEveryDay: everyDay,
                        active: true)
                    notificatSurahViewModel.saveOrDelete(item: item)
                    noficationsManager.pushNotication(item: item)
                    dismiss()
                } label: {
                    Text("save")
                        .bold()
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                }
            }
        }
        .onAppear {
            locationManager.getLocation()
            prayerTimeViewModel.getPrayTime(time: Date(), latitude: location.lat, longitude: location.lang)
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
            .environmentObject(BadgeAppManager())
            .environmentObject(LanguageViewModel())
    }
}
