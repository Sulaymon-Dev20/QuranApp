//
//  View.swift
//  QuranApp
//
//  Created by Sulaymon on 27/05/23.
//

import SwiftUI

extension View {
    @ViewBuilder
    func forceRotation(orientation: UIInterfaceOrientationMask) -> some View {
        self.onAppear() {
            MyAppDelegate.orientationLock = orientation
        }
    }
    
    @ViewBuilder
    func alertPermissions(showAlert: Binding<Bool>, title: LocalizedStringKey, message: LocalizedStringKey) -> some View {
        self
            .alert(isPresented: showAlert) {
                Alert(
                    title: Text(title),
                    message: Text(message),
                    primaryButton: .destructive(Text("cancel")),
                    secondaryButton: .default(
                        Text("allow"),
                        action: {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    )
                )
            }
    }
    
    @ViewBuilder
    func hiddinNativiation(value: Route) -> some View {
        self
            .overlay {
                NavigationLink(value: value) {
                    Text(">>>")
                }
                .opacity(0)
            }
    }
    
    
    @ViewBuilder
    func hideIfPad() -> some View {
        if UIDevice.current.userInterfaceIdiom != .pad {
            self
        }
    }
    
    @ViewBuilder
    func navigationButton(action event: @escaping () -> Void) -> some View {
        Button {
            event()
        } label: {
            self
        }
        .foregroundColor(Color.primary)
    }
    
    @ViewBuilder
    func viewTabToolbar(searchText: Binding<String>, title: LocalizedStringKey, navigationBarTrailing: AnyView) -> some View {
        self
            .searchable(text: searchText, placement: .toolbar, prompt: Text("search_surah"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    navigationBarTrailing
                }
            }
    }
    
    @ViewBuilder
    func environmentAllObject(language:String = "ar") -> some View {
        self
            .environmentObject(SurahViewModel())
            .environmentObject(LaunchScreenViewModel())
            .environmentObject(LanguageViewModel())
            .environmentObject(BookMarkViewModel())
            .environmentObject(NotificatSurahViewModel())
            .environmentObject(RouterManager())
            .environmentObject(JuzViewModel())
            .environmentObject(LocationManager())
            .environmentObject(NoficationsManager())
            .environmentObject(PrayerTimeManager())
            .environmentObject(ReviewsRequestManager())
            .environmentObject(BadgeAppManager())
            .environmentObject(ColorSchemeManager())
            .environmentObject(NecessaryMenuViewModel())
            .environment(\.locale, Locale.init(identifier: language))
    }
}

