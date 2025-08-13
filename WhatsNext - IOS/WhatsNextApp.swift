//___FILEHEADER___
import SwiftUI

@main
struct WhatsNextApp: App {
    
    
    init() {
        print("[DEBUG] Secrets.tmApiKey:", Secrets.tmApiKey.isEmpty ? "nil/empty" : Secrets.tmApiKey)
    }

    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

