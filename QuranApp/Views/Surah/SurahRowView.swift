//
//  SurahRowView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct SurahRowView: View {
    @EnvironmentObject var routerManager: RouterManager
    @EnvironmentObject var languageViewModel: LanguageViewModel

    let item: SurahModel
    let status: Bool
    
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "square.dashed")
                    .font(.system(size: 34.0))
                    .overlay {
                        Text("\(item.index)".convertedDigitsToLocale(languageViewModel.language))
                            .font(.system(size: 11.0))
                    }
                VStack{
                    HStack {
                        Text(LocalizedStringKey(item.title.localizedForm))
                            .bold()
                        Spacer()
                    }
                    HStack {
                        Text(LocalizedStringKey(item.type == TypeEnum.madaniyah ? "madaniyah" : "makkiyah"))
                            .fontWeight(Font.Weight.ultraLight)
                        Text("\(item.count)")
                            .fontWeight(Font.Weight.ultraLight)
                        Spacer()
                    }
                }
                .badge(Int(item.pages.intValue))
            }
            .navigationButton(action: {
                routerManager.setCurrentPage(to: item.pages.intValue)
            })
            .hiddinNativiation(value: Route.menu(item: item))
            if status {
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "bookmark.fill")
                            .padding(.top, -5)
                            .frame(width: 100, alignment: .center)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct SurahRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SurahRowView(item: SurahModel(place: Place.mecca, type: TypeEnum.madaniyah, count: 12, title: "asdf", titleAr: "asdf", index: "adsf", pages: "asdf", juz: []), status: false)
        }
        .environmentAllObject()
    }
}
