//
//  LanguageButtonView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct LanguageButtonView: View {
    @EnvironmentObject var datas: LanguageViewModel

    var body: some View {
        Menu {
            Button(action: {
                datas.changeLanugae(lang: "ar")
            }) {
                Label("arabic", image: "ar")
            }
            Button(action: {
                datas.changeLanugae(lang: "en")
            }) {
                Label("english", image: "en")
            }
            Button(action: {
                datas.changeLanugae(lang: "uz")
            }) {
                Label("uzbek", image: "uz")
            }
            Button(action: {
                datas.changeLanugae(lang: "ru")
            }) {
                Label("russian", image: "ru")
            }
        } label: {
            Image(datas.language)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding(.top, 5)
        }
        .environment(\.locale, Locale.init(identifier: datas.language))
    }
}

struct LanguageButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageButtonView()
            .environmentObject(LanguageViewModel())
    }
}
