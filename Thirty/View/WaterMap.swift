//
//  WaterMap.swift
//  Thirty
//
//  Created by Eric Terrisson on 20/04/2024.
//

import SwiftUI
import MapKit
import CoreLocation

struct WaterMap: View {
    
    @StateObject private var locationManager = LocationManager()
    
   
    
    @State private var isDirectionShow: Bool = false
    @State private var isButtonHidden: Bool = true
    @State private var title: String = ""
    @State private var address: String = ""
    @State private var distance: Double = 0.0
    @State private var travelTime: Double = 0.0
    
    var body: some View {
        VStack {
            
            if let location = locationManager.location {
                MapView(location: location, title: $title, address: $address, distance: $distance, travelTime: $travelTime, isButtonHidden: $isButtonHidden)
                    .ignoresSafeArea()
                
            } else {
                // Afficher un indicateur de chargement ou un message en attendant que la localisation soit déterminée
                ProgressView("Determining Location...")
            }
            if (isDirectionShow) {
                
            } else {
                
                SelectionView(title: $title, address: $address, distance: $distance, travelTime: $travelTime, isDirectionShow: $isDirectionShow, isButtonHidden: $isButtonHidden)
                
            }
        }
    }
}

struct WaterMap_Previews: PreviewProvider {
    static var previews: some View {
        WaterMap()
    }
}
