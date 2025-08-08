//
//  HomeView.swift
//  WhatsNext
//
//  Created by Allan Constanza
//
import SwiftUI

struct HomeView: View {
    @State private var searchTerm = ""

  
    let cities = [
        City(name: "San Francisco",
             landmarks: ["Golden Gate Bridge", "Pier 39", "Oracle Park", "Golden Gate Bridge", "Pier 39", "Oracle Park"],
             events: ["Food Festival", "Jazz Night", "Tech Meetup", "Fancy Dinner", "Dog Parade", "Gaga Concert", "Drake Concert", "Warriors Playoffs", "Tech Conference", "Event1", "Event2", "Event3"],
             imageName: "SF"),
        City(name: "Los Angeles",
             landmarks: ["Hollywood Sign", "Santa Monica Pier", "Universal Studios", "Venice Beach"],
             events: ["Film Screening", "Comedy Night", "Rams vs Chargers", "Dodgers vs Giants", "Kendrick Lamar Concert"],
             imageName: "LA"),
        City(name: "New York",
             landmarks: ["Central Park", "Statue of Liberty", "Times Square", "Empire State Building"],
             events: ["Broadway Show", "Museum Grand Opening", "Jets vs Giants", "Knicks vs Nets" ],
             imageName: "NYC"),
        City(name: "Dallas",
             landmarks: ["Reunion Tower", "AT&T Stadium", "Aquarium", "Sightseeing"],
             events: ["Cowboys vs Eagles", "Mavs vs Celtics", "Food Festival", "Jazz Night", "Tech Meetup"],
             imageName: "Dallas"),
        City(name: "Chicago",
             landmarks: ["Millennium Park", "Navy Pier", "Wrigley Field", "Field Museum"],
             events: ["Bears vs Packers", "Dua Lipa Concert", "Cubs vs Yankees", "Food Festival", "Jazz Night", "Tech Meetup"],
             imageName: "Chicago"),
        City(name: "Miami",
             landmarks: ["South Beach", "Everglades National Park", "Hard Rock Stadium", "Bayside Marketplace"],
             events: ["Heat vs Cavs", "Dolphins vs Bills", "Food Festival", "Jazz Night", "Tech Meetup"],
             imageName: "Miami")
    ]

    var filteredCities: [City] {
        guard !searchTerm.isEmpty else { return cities }
        return cities.filter { $0.name.localizedStandardContains(searchTerm) }
    }

    var body: some View {
        NavigationStack {
            Group {
                if filteredCities.isEmpty {
                    
                    VStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .font(.largeTitle)
                            .padding(.bottom, 4)
                        Text("No cities found")
                            .font(.headline)
                        Text("Try a different search term.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(filteredCities) { city in
                        NavigationLink(destination: CityDetailView(city: city)) {
                            CityCardView(city: city)
                        }
                        .listRowSeparator(.automatic)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 8) {
                        Image(systemName: "sparkles")
                            .font(.title3)
                        Text("WhatsNext")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                    }
                    .accessibilityAddTraits(.isHeader)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(.systemBackground), for: .navigationBar)
            .searchable(text: $searchTerm, prompt: "Search Cities")
        }
    }
}


#Preview {
    HomeView()
}
