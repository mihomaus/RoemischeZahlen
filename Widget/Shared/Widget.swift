//
//  Widget_iOS.swift
//  Widget-iOS
//
//  Created by Morten Bertz on 2022/02/25.
//

import WidgetKit
import SwiftUI
import Intents
import XLIICore

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> DateEntry {
        DateEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (DateEntry) -> ()) {
        let entry = DateEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [DateEntry] = []

        let currentDate = Date()
        let calendar=Calendar.current
        //we want to update at 0 seconds to be in synch with other system clocks
        let currentMinuteDate=calendar.date(bySetting: .second, value: 0, of: currentDate) ?? currentDate
        
        let minutesIn6Hours=60*6
        
        for minuteOffset in 0 ..< minutesIn6Hours {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentMinuteDate)!
            let entry = DateEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}


@main
struct Widget_iOS: Widget {
    let kind: String = "Widget_iOS"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetView(entry: entry)
        }
        .configurationDisplayName(Text("XLII"))
        .description(Text("This is a XLII time widget."))
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}


extension Output{
    init?(output:WidgetOutput) {
        switch output{
        case .unknown:
            return nil
        case .babylonian:
            self = .babylonian
        case .aegean:
            self = .aegean
        case .hieroglyph:
            self = .hieroglyph
        case .phoenician:
            self = .phoenician
        case .roman:
            self = .römisch
        case .sangi:
            self = .sangi
        case .suzhou:
            self = .suzhou
        case .japanese:
            self = .japanisch
        case .hexadecimal:
            self = .numeric(base: 16)
        case .binary:
            self = .numeric(base: 2)
        case .octal:
            self = .numeric(base: 8)
        case .vigesimal:
            self = .numeric(base: 20)
        }
    }
}


extension Color{
    static var accent:Color{
#if os(iOS)
        return Color(uiColor: UIColor(named: "AccentColor") ?? .green)
#else
        return Color(nsColor: NSColor(named: "AccentColor") ?? .green)
#endif
    }
    
    static var widgetBackground:Color{
#if os(iOS)
        return Color(uiColor: .quaternarySystemFill)
#else
        return Color(nsColor: .windowBackgroundColor)
#endif
    }
}