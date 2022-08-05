//
//  SuffixWidjet.swift
//  SuffixWidjet
//
//  Created by Anton Agafonov on 04.08.2022.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    let viewModel: ViewModel = .shared
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), suffixes: viewModel.wholeListSuffix)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), suffixes: viewModel.wholeListSuffix)
        print("text", viewModel.text)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries: [SimpleEntry] = []

            let entry = SimpleEntry(date: Date(), suffixes: viewModel.wholeListSuffix)
            entries.append(entry)
        

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let suffixes: [(String, Int)]
}

struct SuffixWidjetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            SmallWidgetScreen(entry: entry)
        default:
            MediumWidgetScreen(entry: entry)
        }
    }
}

@main
struct SuffixWidjet: Widget {
    let kind: String = "SuffixWidjet"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SuffixWidjetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct SuffixWidjet_Previews: PreviewProvider {
    static var previews: some View {
        SuffixWidjetEntryView(entry: SimpleEntry(date: Date(), suffixes: [("tre", 1), ("fgh", 3)]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
