//
//  CityCardView.swift
//  WhatsNext
//
//  Created by Allan Constanza on 8/7/25.
//

import SwiftUI

struct CityCardView: View {
    let city: City
    
    var body: some View {
        HStack(spacing: 16){
            Image(city.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipped()
                            .cornerRadius(10)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(city.name)
                                .font(.title3)
                                .fontWeight(.bold)

                            Text("\(city.landmarks.count) Landmarks")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            
        
