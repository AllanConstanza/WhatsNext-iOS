//
//  CityDetailView.swift
//  WhatsNext
//
//  Created by Allan Constanza 
//
import SwiftUI


struct CityDetailView: View {
    let city: City
    @StateObject private var vm = ViewModel()

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

            
                ZStack(alignment: .bottomLeading) {
                    Image(city.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 240)
                        .clipped()
                        .overlay(
                            LinearGradient(
                                colors: [.clear, .black.opacity(0.55)],
                                startPoint: .center, endPoint: .bottom
                            )
                        )

                    VStack(alignment: .leading, spacing: 4) {
                        Text(city.name)
                            .font(.largeTitle).bold()
                            .foregroundColor(.white)
                            .shadow(radius: 6)
                        if !city.landmarks.isEmpty {
                            Text("\(city.landmarks.count) Landmarks")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.95))
                                .shadow(radius: 3)
                        }
                    }
                    .padding(.leading, 16)
                    .padding(.bottom, 12)
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)

                //
                if !city.landmarks.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Landmarks")
                            .font(.title2).bold()
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(Array(city.landmarks.enumerated()), id: \.offset) { _, lm in
                                HStack(alignment: .top, spacing: 8) {
                                    Image(systemName: "mappin.and.ellipse")
                                        .font(.headline)
                                    Text(lm)
                                        .font(.subheadline)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                //Live Events
                VStack(alignment: .leading, spacing: 8) {
                    Text("Live Events")
                        .font(.title2).bold()
                        .padding(.horizontal)

                    switch vm.state {
                    case .idle, .loading:
                        ProgressView("Fetching events…")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical)

                    case .failed(let message):
                        VStack(spacing: 8) {
                            Text(message).foregroundColor(.red)
                            Button("Try Again") { Task { await vm.load(city: city.name) } }
                                .buttonStyle(.borderedProminent)
                        }
                        .padding(.horizontal)

                    case .loaded(let events):
                        if events.isEmpty {
                            Text("No upcoming events found.")
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                        } else {
                            VStack(spacing: 12) {
                                ForEach(events) { e in
                                    EventRow(event: e)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 12)
                                        .background(.thinMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }

                Spacer(minLength: 8)
            }
            .padding(.top, 12)
        }
        .navigationTitle(city.name)
        .navigationBarTitleDisplayMode(.inline)
        .task { await vm.load(city: city.name) }
    }
}

//A single event row
private struct EventRow: View {
    let event: TMEvent

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: bestImageURL) { phase in
                switch phase {
                case .empty: ProgressView()
                case .success(let img): img.resizable().scaledToFill()
                case .failure: Color.gray.opacity(0.2)
                @unknown default: Color.gray.opacity(0.2)
                }
            }
            .frame(width: 84, height: 84)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 4) {
                Text(event.name).font(.headline).lineLimit(2)
                if let dateText { Text(dateText).font(.subheadline).foregroundColor(.secondary) }
                if let venueText { Text(venueText).font(.subheadline) }
                if let url = event.url, let link = URL(string: url) {
                    Link("View on Ticketmaster", destination: link)
                        .font(.footnote)
                }
            }
            Spacer()
        }
    }

    private var bestImageURL: URL? {
        event.images?
            .sorted { ($0.width ?? 0) > ($1.width ?? 0) }
            .first?.url
            .flatMap(URL.init(string:))
    }

    private var dateText: String? {
        if let d = event.dates?.start?.localDate, let t = event.dates?.start?.localTime {
            return "\(d) • \(t)"
        }
        return event.dates?.start?.localDate
    }

    private var venueText: String? {
        let v = event.embedded?.venues?.first
        let city = v?.city?.name ?? ""
        let state = v?.state?.stateCode ?? ""
        let name = v?.name ?? ""
        let place = [city, state].filter { !$0.isEmpty }.joined(separator: ", ")
        return [name, place].filter { !$0.isEmpty }.joined(separator: " • ")
    }
}

//ViewModel
@MainActor
final class ViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded([TMEvent])
        case failed(String)
    }

    @Published var state: State = .idle

    func load(city: String) async {
        if case .loading = state { return }
        state = .loading
        do {
            let events = try await TicketmasterAPI.shared.events(
                forCity: city,
                from: Date(),
                daysAhead: 60
            )
            state = .loaded(events)
        } catch TMAPIError.missingKey {
            state = .failed("Missing TM_API_KEY. Add it in Secrets.plist.")
        } catch TMAPIError.badStatus(let code) {
            state = .failed("Ticketmaster request failed (\(code)).")
        } catch {
            state = .failed("Unexpected error: \(error.localizedDescription)")
        }
    }
}
