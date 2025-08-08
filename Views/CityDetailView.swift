//
//  CityDetailView.swift
//  WhatsNext
//
//  Created by Allan Constanza on 8/7/25.
//

import SwiftUI

struct CityDetailView: View {
    let city: City

    var body: some View {
        List{
            Section(header: Text("Landmarks")){
                ForEach(city.landmarks, id: \.self){ landmark in
                    Text(landmark)
                }
            }
            
            Section(header: Text("Events")){
                ForEach(city.events, id: \.self){ event in
                    Text(event)
                }
            }
        }
        .navigationTitle(city.name)
    }
    
}
