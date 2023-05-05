//
//  JuzTestView.swift
//  QuranApp
//
//  Created by Sulaymon on 05/05/23.
//

import SwiftUI

struct JuzTestView: View {
    let item:[JuzModel]
    @Binding var hiddenBar: Bool
    @State private var isLoading = false
    var body: some View {
        VStack {
            Text("Juzs")
                .font(.title)
                .bold()
            Text("Juzs dsajf asdf jas dfasfdsadf")
                .font(.caption)
                .padding(.bottom)
            VStack{
                ForEach(0..<(item.count / 5), id: \.self) { i in
                    HStack{
                        ForEach(0..<5) { i2 in
                            VStack {
                                Image(systemName: "app")
                                    .font(.system(size: 50.0))
                                    .overlay {
                                        Text("\(item[(i * 5) + i2].index)")
                                            .font(.system(size: 22.0))
                                    }
                                    .contextMenu{
                                        ForEach(item[(i * 5) + i2].surahs, id: \.index) {surahs in
                                            NavigationLink(destination: PDFViewUI(pageNumber: (surahs.pageNumber as NSString).integerValue, hiddenBar: $hiddenBar)
                                                .onAppear {
                                                    self.hiddenBar = true
                                                }
                                            ) {
                                                Label(LocalizedStringKey(surahs.title.lowercased().replacingOccurrences(of: "-", with: "_")), systemImage: surahs.type == "Makkiyah" ? "moon.fill" : "sun.max.fill")
                                            }
                                        }
                                    }
                                    .padding(.bottom, 11)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct JuzTestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JuzTestView(item: [
                JuzModel(index: 1, page: 1, surahs: []),
                JuzModel(index: 2, page: 1, surahs: []),
                JuzModel(index: 3, page: 1, surahs: []),
                JuzModel(index: 4, page: 1, surahs: []),
                JuzModel(index: 5, page: 1, surahs: []),
                
                JuzModel(index: 6, page: 1, surahs: []),
                JuzModel(index: 7, page: 1, surahs: []),
                JuzModel(index: 8, page: 1, surahs: []),
                JuzModel(index: 9, page: 1, surahs: []),
                JuzModel(index: 10, page: 1, surahs: []),
                
                JuzModel(index: 11, page: 1, surahs: []),
                JuzModel(index: 12, page: 1, surahs: []),
                JuzModel(index: 13, page: 1, surahs: []),
                JuzModel(index: 14, page: 1, surahs: []),
                JuzModel(index: 14, page: 1, surahs: [])
            ], hiddenBar: .constant(false))
        }
    }
}
