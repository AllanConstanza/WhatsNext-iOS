//
//  HomeView.swift
//  WhatsNext
//
//  Created by Allan Constanza on 8/7/25.
//

import SwiftUI

struct HomeView: View {
    let cities = [City(
        name: "San Francisco",
        landmarks: ["Golden Gate Bridge", "Pier 39", "Oracle Park"],
        events: ["Food Festival", "Jazz Night", "Tech Meetup"],
        imageName: "SF"
    ),
    City(
        name: "Los Angeles",
        landmarks: ["Hollywood Sign", "Santa Monica Pier"],
        events: ["Film Screening", "Comedy Night"],
        imageName: "LA"
    ),
    City(
        name: "New York",
        landmarks: ["Central Park", "Statue of Liberty"],
        events: ["Broadway Show", "Museum Tour"],
        imageName: "NYC"
    )]
    
    var body: some View {
        NavigationStack {
            List(cities) { city in
                NavigationLink(destination: CityDetailView(city: city)) {
                    CityCardView(city: city)
                }
            }

            .navigationTitle("WhatsNext")
            
        }
    }
}

#Preview {
    HomeView()
}
