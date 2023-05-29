//
//  Spotlight.swift
//  QuranApp
//
//  Created by Sulaymon on 30/05/23.
//

import SwiftUI

extension View {
    @ViewBuilder
    func addSpotlight(_ id: Int, shape: SpotlightShape = .rectangle, roundedRadius: CGFloat = 0, text: String = "") -> some View {
        self
            .anchorPreference(key: BoundsKey.self, value: .bounds, transform: {
                [id:BoundsKeyProperties(shape: shape, anchor: $0,text: text,radius: roundedRadius)]
            })
    }
    
    @ViewBuilder
    func addSpotlightOverlay(show: Binding<Bool>,currentSpot: Binding<Int>) -> some View {
        self
            .overlayPreferenceValue(BoundsKey.self) { values in
                GeometryReader { proxy in
                    if let preference = values.first(where: {item in
                        item.key == currentSpot.wrappedValue
                    }) {
                        let screenSize = proxy.size
                        let ancher = proxy[preference.value.anchor]
                        SpotlightHelperView(screenSize: screenSize, rect: ancher, show:show, currentSpot: currentSpot,properties: preference.value) {
                            if currentSpot.wrappedValue <= (values.count) {
                                currentSpot.wrappedValue += 1
                            } else {
                                show.wrappedValue = false
                            }
                        }
                    }
                }
                .ignoresSafeArea()
                .animation(.easeInOut, value: show.wrappedValue)
                .animation(.easeInOut, value: currentSpot.wrappedValue)
            }
    }
    
    @ViewBuilder
    func SpotlightHelperView(screenSize: CGSize, rect: CGRect, show: Binding<Bool>,currentSpot: Binding<Int>,properties: BoundsKeyProperties, onTap: @escaping () -> ()) -> some View {
        Rectangle()
            .fill(.ultraThinMaterial)
            .environment(\.colorScheme, .dark)
            .opacity(show.wrappedValue ? 0.9 : 0)
            .mask {
                Rectangle()
                    .overlay(alignment: .topLeading) {
                        let radius = properties.shape == .circle ? (rect.width / 2) : (properties.shape == .rectangle ? 0 : properties.radius)
                        RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .frame(width: rect.width, height: rect.height)
                            .offset(x: rect.minX, y: rect.minY) //bug with x
                            .blendMode(.destinationOut)
                    }
            }
            .overlay(alignment: .topLeading) {
                Text(properties.text)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .opacity(0)
                    .overlay {
                        GeometryReader { proxy in
                            let textSize = proxy.size
                            Text(properties.text)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .offset(x: (rect.minX + textSize.width) > (screenSize.width - 15) ?
                                        -((rect.minX + textSize.width) - (screenSize.width - 15)) : 0)
                                .offset(y: (rect.maxY + textSize.height) > (screenSize.height - 50) ?
                                        -(textSize.height - (rect.maxY - rect.minY) + 30) : 30)
                        }
                        .offset(x:rect.minX, y:rect.maxY)
                    }
            }
            .onTapGesture {
                onTap()
            }
    }
}

enum SpotlightShape {
    case circle
    case rectangle
    case rounded
}

struct BoundsKey: PreferenceKey {
    static var defaultValue: [Int: BoundsKeyProperties] = [:]
    
    static func reduce(value: inout [Int : BoundsKeyProperties], nextValue: () -> [Int : BoundsKeyProperties]) {
        value.merge(nextValue()){$1}
    }
}

struct BoundsKeyProperties {
    var shape: SpotlightShape
    var anchor: Anchor<CGRect>
    var text: String = ""
    var radius: CGFloat = 0
}


struct Spotlight_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
            .environmentObject(ReviewsRequestManager())
            .environmentObject(BadgeAppManager())
            .environmentObject(SpotlightManager())
    }
}
