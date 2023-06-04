//
//  PreyTimeWidget.swift
//  PreyTimeWidget
//
//  Created by Sulaymon on 03/06/23.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), preyTime: [])
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), preyTime: [])
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    }
}

struct SimpleEntry: Codable, TimelineEntry {
    var date: Date
    var preyTime: [PreyTimeModel]
}

struct PreyTimeModel: Codable {
    var name: String
    var time: Date
}

struct PreyTimeWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct PreyTimeWidget: Widget {
    let kind: String = "PreyTimeWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            PreyTimeWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct PreyTimeWidget_Previews: PreviewProvider {
    static var previews: some View {
        PreyTimeWidgetEntryView(entry: SimpleEntry(date: Date(), preyTime: []))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
