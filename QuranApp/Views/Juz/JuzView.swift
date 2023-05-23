//
//  JuzView.swift
//  QuranApp
//
//  Created by Sulaymon on 04/05/23.
//

import SwiftUI

struct JuzView: View {
    @ObservedObject var datas = JuzViewModel()
    
    @Binding var selectedTab: Int
    @Binding var hiddenBar: Bool
    @State var sort: Bool = false
    @State var degree: Double = 0
    
    var body: some View {
        NavigationStack {
            ZStack{
                if !datas.showStatus {
                    List {
                        ForEach(sort ? datas.items.reversed() : datas.items, id: \.index) {item in
                            JuzRowView(item: item, hiddenBar: $hiddenBar)
                        }
                    }
                } else {
                    JuzCalendarView(item: sort ? datas.items.reversed() : datas.items, hiddenBar: $hiddenBar)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(hiddenBar ? .hidden : .visible, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Button {
                        datas.changeView(status: !datas.showStatus)
                    } label: {
                        Text("juz")
                            .bold()
                            .foregroundColor(Color.primary)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    LanguageButtonView()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            self.sort = !sort
                            degree += 180
                        }
                    } label: {
                        Image(systemName: "arrow.up")
                            .rotationEffect(.degrees(degree))
                            .animation(.linear(duration: 0.3), value: sort)
                        
                    }
                }
            }
        }
    }
}

struct JuzView_Previews: PreviewProvider {
    static var previews: some View {
        JuzView(selectedTab: .constant(1), hiddenBar: .constant(false))
            .environmentObject(JuzViewModel())
            .environmentObject(BookMarkViewModel())
            .environmentObject(LanguageViewModel())
        //            .environment(\.locale, Locale.init(identifier: "ar"))
    }
}
