//
//  SurahRowView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct SurahRowView: View {
    let number: Int
    let name: String
    let type: TypeEnum
    let verses: Int
    let pageNumber: String
    let status: Bool
    
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "square.dashed")
                    .font(.system(size: 34.0))
                    .overlay {
                        Text("\(number)")
                            .font(.system(size: 11.0))
                    }
                VStack{
                    HStack {
                        Text(LocalizedStringKey(name.localizedForm))
                            .bold()
                        Spacer()
                    }
                    HStack {
                        Text(LocalizedStringKey(type == TypeEnum.madaniyah ? "madaniyah" : "makkiyah"))
                            .fontWeight(Font.Weight.ultraLight)
                        Text("\(verses)")
                            .fontWeight(Font.Weight.ultraLight)
                        Spacer()
                    }
                }
                .badge(Int(pageNumber.intValue))
            }
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
            SurahRowView(number: 1, name: "Al-Fatiha", type: TypeEnum.madaniyah, verses: 7, pageNumber: "1", status: false)
            SurahRowView(number: 1, name: "Al-Fatiha", type: TypeEnum.madaniyah, verses: 7, pageNumber: "1", status: true)
        }
        .environment(\.locale, Locale.init(identifier: "ar"))
    }
}
