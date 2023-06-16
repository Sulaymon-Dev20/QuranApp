//
//  DateTimeView.swift
//  QuranApp
//
//  Created by Sulaymon on 16/06/23.
//

import SwiftUI

struct DateTimeView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let time:Date
    let update: () -> Void

    @State var viewTime:Date = Date()

    var body: some View {
        Text("\(viewTime.fullTimeForm)")
            .font(.footnote)
            .frame(width: 90)
            .onReceive(timer, perform: { _ in
                self.viewTime = Date().diffTwoTime(from: time)
                if time.intValue < Date().intValue {
                    update()
                }
            })
    }
}

struct DateTimeView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Spacer()
            Text("asdf")
            DateTimeView(time: Date()) {
                print("update")
            }
            Text("asdf")
        }
    }
}
