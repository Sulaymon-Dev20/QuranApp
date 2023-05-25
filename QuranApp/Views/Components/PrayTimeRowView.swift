//
//  PrayTimeRowView.swift
//  QuranApp
//
//  Created by Sulaymon on 25/05/23.
//

import SwiftUI
import Adhan

struct PrayTimeRowView: View {
    @EnvironmentObject var prayerTimeViewModel: PrayerTimeManager
    @EnvironmentObject var locationManager: LocationManager
    
    @State var showAlert: Bool = false
    @State var mashab: Madhab = .hanafi

    var body: some View {
        let show = locationManager.checkLocationPermission()
        Section {
            let data = prayerTimeViewModel.getPrayTime(time: Date(), madhab: mashab,latitude: locationManager.location?.latitude ?? 0.0, longitude: locationManager.location?.longitude ?? 0.0)
            ZStack {
                VStack {
                    ForEach(data, id: \.name) { item in
                        HStack {
                            Image(systemName: getImg(time: item.name))
                            Text(item.name)
                                .bold()
                            Spacer()
                            Text(item.time.clockString)
                                .bold()
                        }.padding(.vertical, 5)
                    }
                }
                .blur(radius: show ? 0 : 8)
                Button {
                    if !show {
                        showAlert = true
                    }
                    locationManager.getLocation()
                } label: {
                    PermissionDenied(img: "paperplane.circle.fill", text: "Location Denited")
                        .frame(maxWidth: .infinity)
                }
                .opacity(show ? 0 : 1)
                AlertPermissions(showAlert: $showAlert, title: "Location allow", message: "open and allow notification please")
            }
        } header: {
            HStack {
                Text("select mathhab to time ")
                Spacer()
                Picker("Vaqtini tanlang", selection: $mashab, content: {
                    Text("hanafi")
                        .tag(Madhab.hanafi)
                    Text("shafi")
                        .tag(Madhab.shafi)
                })
                .opacity(show ? 1 : 0)
            }
        } footer: {
            Button {
                locationManager.request()
            } label: {
                HStack(alignment: .center) {
                    Image(systemName: "paperplane")
                    Text("Location update")
                }
                .opacity(show ? 1 : 0)
            }
        }
    }
    
    func getImg(time: String) -> String {
        switch time {
        case "fajr":
            return "moon.fill"
        case "sunrise":
            return "sun.haze"
        case "dhuhr":
            return "sun.max.fill"
        case "maghrib":
            return "moon.haze.fill"
        case "isha":
            return "moon.stars"
        default:
            return "sun.max"
        }
    }
}

struct PrayTimeRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                PrayTimeRowView()
            }
            .environmentObject(SurahViewModel())
            .environmentObject(LaunchScreenViewModel())
            .environmentObject(LanguageViewModel())
            .environmentObject(BookMarkViewModel())
            .environmentObject(NotificatSurahViewModel())
            .environmentObject(RouterManager())
            .environmentObject(JuzViewModel())
            .environmentObject(NoficationsManager())
            .environmentObject(PrayerTimeManager())
            .environmentObject(LocationManager())
        }
    }
}
