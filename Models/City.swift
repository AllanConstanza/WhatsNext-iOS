//
//  City.swift
//  WhatsNext
//
//  Created by Allan Constanza on 8/7/25.
//

import Foundation

struct City: Identifiable {
    let id = UUID()
    let name: String
    let landmarks: [String]
    let events: [String]
    let imageName: String
}
