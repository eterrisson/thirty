//
//  ContentView.swift
//  Thirty
//
//  Created by Eric Terrisson on 20/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var waveOffset: CGFloat = 0
    @State private var goToMap: Bool = false
    
    var body: some View {
        
        if (goToMap) {
            WaterMap()
        } else {
        
            GeometryReader { geometry in
                ZStack {
                    
                    VStack {
                        Text("Thirty")
                            .font(.custom("AmericanTypewriter", size: 42))
                            .foregroundColor(.cyan)
                        
                        Button {                            
                            goToMap.toggle()
                        } label: {
                            HStack {
                                Text("Find Water")
                                    .foregroundColor(.white)
                                
                                Image(systemName: "drop.fill")
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(.cyan)
                            .cornerRadius(99)
                        }
                    }
                    
                    Wave()
                        .fill(Color.cyan)
                        .frame(height: geometry.size.height + 50)
                        .offset(x: 0, y: 100 + waveOffset)
                        .ignoresSafeArea()
                        .onAppear {
                            withAnimation(Animation.linear(duration: 5)) {
                                self.waveOffset = geometry.size.height + 50 // Animation vers le haut
                            }
                        }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
