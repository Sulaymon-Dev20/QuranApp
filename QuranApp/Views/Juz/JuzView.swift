//
//  JuzView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct JuzView: View {
    @EnvironmentObject var routerManager: RouterManager
    @EnvironmentObject var datas: JuzViewModel
        
    var body: some View {
        List {
            ForEach(routerManager.sort ? datas.items.reversed() : datas.items, id: \.index) { item in
                JuzRowView(item: item)
            }
        }
        .animation(.linear(duration: 3.0), value: routerManager.sort)
        .onAppear {
            //            requestReview()
        }
        .onDisappear {
        }
    }
}

struct JuzView_Previews: PreviewProvider {
    static var previews: some View {
        JuzView()
            .environmentObject(JuzViewModel())
            .environmentObject(BookMarkViewModel())
            .environmentObject(LanguageViewModel())
            .environmentObject(RouterManager())
        //            .environment(\.locale, Locale.init(identifier: "ar"))
    }
}
