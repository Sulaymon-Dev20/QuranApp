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
    var body: some View {
        HStack {
            Image(systemName: "square.dashed")
                .font(.system(size: 34.0))
                .overlay {
                    Text("\(number)")
                        .font(.system(size: 11.0))
                }
            VStack{
                HStack{
                    Text(LocalizedStringKey(name.lowercased().replacingOccurrences(of: "-", with: "_")))
                        .bold()
                    Spacer()
                }
                HStack{
                    Text(LocalizedStringKey(type == TypeEnum.madaniyah ? "madaniyah" : "makkiyah"))
                        .fontWeight(Font.Weight.ultraLight)
                    Text("\(verses)")
                        .fontWeight(Font.Weight.ultraLight)
                    Spacer()
                }
            }
            Text("\((pageNumber as NSString).intValue)")
                .font(.system(size: 22.0))
                .opacity(0.5)
                .bold()
        }
    }
}

struct SurahRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SurahRowView(number: 1, name: "Al-Fatiha", type: TypeEnum.madaniyah, verses: 7, pageNumber: "1")
        }
        .environment(\.locale, Locale.init(identifier: "ar"))
    }
}
