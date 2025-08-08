//
//  CityDetailView.swift
//  WhatsNext
//
//  Created by Allan Constanza 
//

import SwiftUI

struct CityDetailView: View {
    let city: City

    private let eventCols = [GridItem(.flexible(), spacing: 12),
                             GridItem(.flexible(), spacing: 12)]

    var body: some View {
        ScrollView {
            Image(city.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 220)
                .clipped()
                .cornerRadius(14)
                .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) {
                Text("Landmarks")
                    .font(.headline)
                    .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(city.landmarks, id: \.self) { lm in
                            Text(lm)
                                .font(.subheadline)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(.systemGray6))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color(.separator), lineWidth: 0.5)
                                )
                                .lineLimit(1)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top, 16)

            VStack(alignment: .leading, spacing: 12) {
                Text("Events")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)

                LazyVGrid(columns: eventCols, spacing: 12) {
                    ForEach(city.events, id: \.self) { title in
                        EventTile(title: title)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top, 20)
            .padding(.bottom, 24)
        }
        .navigationTitle(city.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EventTile: View {
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(systemName: "calendar")
                .font(.title3)

            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            Text("Details TBD")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(.systemGray6))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color(.separator), lineWidth: 0.5)
        )
    }
}

