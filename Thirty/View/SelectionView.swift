//
//  SelectionView.swift
//  Thirty
//
//  Created by Eric Terrisson on 22/04/2024.
//

import SwiftUI

struct SelectionView: View {
    
    @Binding var title: String
    @Binding var address: String
    @Binding var distance: Double
    @Binding var travelTime: Double
    @Binding var isDirectionShow: Bool
    @Binding var isButtonHidden: Bool
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .foregroundColor(.cyan)
            
            Text(address)
                .font(.body)
                .foregroundColor(.gray)
            
            if (distance != 0.0 && travelTime != 0.0) {
                HStack {
                    Image(systemName: "figure.walk")
                        .foregroundColor(.orange)
                    Text("\(Int(distance)) m")
                        .font(.body)
                        .foregroundColor(.orange)
                    Spacer()
                }
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.orange)
                    Text(travelTime != 0 ? "\(Int(travelTime / 60)) min" : "")
                        .font(.body)
                        .foregroundColor(.orange)
                    Spacer()
                }
            }
            
            if !isButtonHidden {
                Button {
                    isDirectionShow.toggle()
                } label: {
                    Text("Itinerary")
                        .padding()
                        .foregroundColor(.white)
                        .font(.title)
                        .background(.cyan)
                        .cornerRadius(99)
                }
            }
        }
        .padding()
        .cornerRadius(20)        
    }
}
