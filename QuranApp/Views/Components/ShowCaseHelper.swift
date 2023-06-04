//
//  ShowCaseHelper.swift
//  QuranApp
//
//  Created by Sulaymon on 04/06/23.
//

import SwiftUI

extension View {
    @ViewBuilder
    func showCase(order:Int, title:String, cornerRadius: CGFloat, style: RoundedCornerStyle = .continuous, scale: CGFloat = 1, allowToShow:Bool = true) -> some View {
        if allowToShow {
            self
                .anchorPreference(key: HighlightAnchorKey.self, value: .bounds) { anchor in
                    let highlight = Highlight(anchar: anchor, title: title, cornerRadius: cornerRadius, style: style, scale: scale)
                    return [order: highlight]
                }
        } else {
            self
        }
    }
}

struct ShowCaseRoot: ViewModifier {
    var showHighlights: Bool
    var onFinished: () -> ()
    
    @State private var highlightOrder: [Int] = []
    @State private var currentHightlight: Int = 0
    @State private var showView: Bool = true
    @Namespace private var animation
    
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(HighlightAnchorKey.self) { value in
                highlightOrder = Array(value.keys).sorted()
            }
            .overlayPreferenceValue(HighlightAnchorKey.self) { preferences in
                if highlightOrder.indices.contains(currentHightlight), showHighlights, showView {
                    if let highlight = preferences[highlightOrder[currentHightlight]] {
                        HighlightView(highlight)
                    }
                }
            }
    }
    
    @ViewBuilder
    func HighlightView(_ highlight: Highlight) -> some View {
        GeometryReader { proxy in
            let screenSize: CGSize = proxy.size
            let highlightRect = proxy[highlight.anchar]
            let safeAria = proxy.safeAreaInsets
            
            Rectangle()
                .fill(.black.opacity(0.5))
                .reverseMask {
                    Rectangle()
                        .matchedGeometryEffect(id: "High", in: animation)
                        .frame(width: highlightRect.width + 5, height: highlightRect.height + 5)
                        .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius, style: highlight.style))
                        .scaleEffect(highlight.scale)
                        .offset(x: highlightRect.minX - 2.5, y: highlightRect.minY + safeAria.top - 2.5)
                }
                .overlay(alignment: .topLeading) {
                    Text(highlight.title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .opacity(0)
                        .overlay {
                            GeometryReader { proxy2 in
                                let textSize = proxy2.size
                                Text(highlight.title)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .offset(x: (highlightRect.minX + textSize.width) > (screenSize.width - 15) ?
                                            -((highlightRect.minX + textSize.width) - (screenSize.width - 15)) : 0)
                                    .offset(y: (highlightRect.maxY + textSize.height) > (screenSize.height - 50) ?
                                            -(textSize.height - (highlightRect.maxY - highlightRect.minY) + 40) : 70)
                            }
                            .offset(x: highlightRect.minX, y: highlightRect.maxY)
                        }
                }
                .ignoresSafeArea()
                .onTapGesture {
                    if currentHightlight >= highlightOrder.count - 1 {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            showView = false
                        }
                        onFinished()
                    } else {
                        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.7)) {
                            currentHightlight += 1
                        }
                    }
                }
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: highlightRect.width + 20, height: highlightRect.height + 20)
                .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius, style: highlight.style))
                .scaleEffect(highlight.scale)
                .offset(x: highlightRect.minX - 10, y: highlightRect.minY - 10)
        }
    }
}

fileprivate struct HighlightAnchorKey: PreferenceKey {
    static var defaultValue: [Int: Highlight] = [:]
    
    static func reduce(value: inout [Int : Highlight], nextValue: () -> [Int : Highlight]) {
        value.merge(nextValue()){$1}
    }
}

struct ShowCaseHelper_Previews: PreviewProvider {
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
