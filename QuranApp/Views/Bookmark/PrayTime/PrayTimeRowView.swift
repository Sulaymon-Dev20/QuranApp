//
//  PrayTimeRowView.swift
//  QuranApp
//
//  Created by Sulaymon on 25/05/23.
//

import SwiftUI

struct PrayTimeRowView: View {
    @EnvironmentObject var prayerTimeViewModel: PrayerTimeManager
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var languageViewModel: LanguageViewModel
    
    @State var showAlert: Bool = false
    
    var body: some View {
        let show = locationManager.checkLocationPermission()
        let loading = locationManager.loading
        let location = locationManager.location
        Section {
            let commingIndex = prayerTimeViewModel.firstPrayTimeIndex()
            ZStack {
                VStack {
                    ForEach(Array(prayerTimeViewModel.prayTimes.enumerated()), id: \.offset) { index, item in
                        HStack {
                            Image(systemName: prayerTimeViewModel.getIcon(time: item.name))
                                .frame(width: 20, alignment: .center)
                            Text(LocalizedStringKey(item.name.localizedForm))
                                .bold()
                            Spacer()
                            if index == commingIndex {
                                DateTimeView(time: item.time) {
                                    prayerTimeViewModel.updateTimes(time: Date(), latitude: location.lat, longitude: location.lang)
                                }
                            }
                            Text(item.time.clockString.convertedDigitsToLocale(languageViewModel.language))
                                .bold()
                                .frame(width: 60, alignment: .center)
                        }
                        .foregroundColor(index == commingIndex ? Color.blue : Color.primary)
                        .padding(.vertical, 5)
                    }
                }
                .blur(radius: show && !loading ? 0 : 8)
                Button {
                    if !show {
                        showAlert = true
                    }
                    locationManager.getLocation()
                } label: {
                    PermissionDenied(img: "paperplane.circle.fill", text: "locationPermissionDenied")
                        .frame(maxWidth: .infinity)
                }
                .opacity(show ? 0 : 1)
                ProgressView()
                    .opacity(show && loading ? 1 : 0)
                AlertPermissions(showAlert: $showAlert, title: "locationPermission", message: "allowLocationToUsePlease")
            }
            .contextMenu {
                if show && !loading {
                    ShareLink(item: prayerTimeViewModel.shareText(lanuage: languageViewModel.language)) {
                        Label("shareButton", systemImage: "square.and.arrow.up")
                    }
                }
            }
        } header: {
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
                    prayerTimeViewModel.updateTimes(time: Date(), latitude: location.lat, longitude: location.lang)
                }
                .frame(width: 120, alignment: .trailing)
            }
        } footer: {
            Button {
                locationManager.request()
            } label: {
                HStack(alignment: .center) {
                    Image(systemName: "paperplane")
                    Text("locationUpdate")
                }
                .opacity(show ? 1 : 0)
            }
        }
        .onAppear {
            locationManager.getLocation()
            prayerTimeViewModel.updateTimes(time: Date(), latitude: location.lat, longitude: location.lang)
        }
    }
}

struct PrayTimeRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                PrayTimeRowView()
            }
            .environmentAllObject()
        }
    }
}
