//
//  TicketmasterModels.swift
//  WhatsNext - IOS
//
//  Created by Allan Constanza
//

import Foundation

struct TMEventsResponse: Codable {
    let embedded: TMEmbedded?

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}

// Holds array of events
struct TMEmbedded: Codable {
    let events: [TMEvent]?
}

// Represents a single event
struct TMEvent: Codable, Identifiable {
    let id: String
    let name: String
    let dates: TMDates?
    let images: [TMImage]?
    let url: String?
    let priceRanges: [TMPriceRange]?
    let embedded: TMEventEmbedded?

    enum CodingKeys: String, CodingKey {
        case id, name, dates, images, url, priceRanges
        case embedded = "_embedded"
    }
}

struct TMDates: Codable { let start: TMStart? }
struct TMStart: Codable {
    let localDate: String?
    let localTime: String?
    let dateTime: String?
}

struct TMImage: Codable {
    let url: String?
    let width: Int?
    let height: Int?
}

struct TMEventEmbedded: Codable { let venues: [TMVenue]? }

struct TMVenue: Codable {
    let name: String?
    let city: TMNameOnly?
    let state: TMStateInfo?
    let address: TMAddress?
}

struct TMNameOnly: Codable { let name: String? }
struct TMStateInfo: Codable {
    let stateCode: String?
    let name: String?
}
struct TMAddress: Codable { let line1: String? }

struct TMPriceRange: Codable {
    let min: Double?
    let max: Double?
    let currency: String?
}
