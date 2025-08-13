//
//  Secrets.swift
//  WhatsNext - IOS
//
//  Created by Allan Constanza
//

import Foundation

//reads Secrets.plist and exposes the API key
enum Secrets {
    static var tmApiKey: String {
        guard let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let dict = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any],
              let key = dict["TM_API_KEY"] as? String
        else {
            print("[DEBUG] Secrets.plist missing or TM_API_KEY not found")
            return ""
        }
        return key
    }
}

