//
//  LanguageButtonView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct LanguageButtonView: View {
    @EnvironmentObject var datas: LanguageViewModel
    var miniView:Bool = true
    
    var body: some View {
        Menu {
            Button(action: {
                datas.changeLanugae(lang: "ar")
            }) {
                Label(getFullText("ar"), image: "ar")
            }
            Button(action: {
                datas.changeLanugae(lang: "en")
            }) {
                Label(getFullText("en"), image: "en")
            }
            Button(action: {
                datas.changeLanugae(lang: "ru")
            }) {
                Label(getFullText("ru"), image: "ru")
            }
            Button(action: {
                datas.changeLanugae(lang: "uz")
            }) {
                Label(getFullText("uz"), image: "uz")
            }
        } label: {
            if miniView {
                Image(datas.language)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(.top, 5)
            } else {
                Text(getFullText(datas.language))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background {
                        Capsule()
                            .fill(Color.red)
                    }
                    .padding(.horizontal, 100)
            }
        }
    }
    
    func getFullText(_ shortCode: String) -> LocalizedStringKey {
        switch shortCode {
        case "ar":
            return "arabic"
        case "en":
            return "english"
        case "ru":
            return "russian"
        case "uz":
            return "uzbek"
        default:
            return "arabic"
        }
    }
}

struct LanguageButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageButtonView()
            .environmentAllObject()
    }
}
