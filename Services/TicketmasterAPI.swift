//
//  TicketmasterAPI.swift
//  WhatsNext - IOS
//
//  Created by Allan Constanza
//

import Foundation

enum TMAPIError: Error { case missingKey, badStatus(Int) }

final class TicketmasterAPI {
    static let shared = TicketmasterAPI()
    private init() {}

    private var apiKey: String { Secrets.tmApiKey }

    private func isoUTC(_ date: Date) -> String {
        let f = ISO8601DateFormatter()
        f.timeZone = TimeZone(secondsFromGMT: 0)
        f.formatOptions = [.withInternetDateTime]
        return f.string(from: date)
    }

    func events(
        forCity city: String,
        from start: Date = Date(),
        daysAhead: Int = 90,
        size: Int = 150,
        segmentName: String? = nil 
    ) async throws -> [TMEvent] {
        guard !apiKey.isEmpty else { throw TMAPIError.missingKey }

        var comps = URLComponents(string: "https://app.ticketmaster.com/discovery/v2/events.json")!

        let end = Calendar.current.date(byAdding: .day, value: daysAhead, to: start) ?? start

        var items: [URLQueryItem] = [
            .init(name: "apikey", value: apiKey),
            .init(name: "city", value: city),
            .init(name: "countryCode", value: "US"),
            .init(name: "sort", value: "date,asc"),
            .init(name: "size", value: String(size)),
            .init(name: "startDateTime", value: isoUTC(start)),
            .init(name: "endDateTime", value: isoUTC(end))
        ]
        if let segmentName { items.append(.init(name: "segmentName", value: segmentName)) }

        comps.queryItems = items

        let (data, resp) = try await URLSession.shared.data(from: comps.url!)
        let code = (resp as? HTTPURLResponse)?.statusCode ?? -1
        guard (200...299).contains(code) else { throw TMAPIError.badStatus(code) }

        let decoded = try JSONDecoder().decode(TMEventsResponse.self, from: data)
        return decoded.embedded?.events ?? []
    }
}
