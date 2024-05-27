//
//  Shape.swift
//  Thirty
//
//  Created by Eric Terrisson on 20/04/2024.
//

import SwiftUI

struct Wave: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX - 1, y: rect.minY))
        path.addCurve(
            to: CGPoint(x: rect.maxX + 1, y: rect.minY),
            control1: CGPoint(x: rect.maxX / 4, y: -(rect.maxX / 4)),
            control2: CGPoint(x: 3 * rect.maxX / 4, y: rect.maxX / 4))
        path.addLine(to: CGPoint(x: rect.maxX + 1, y: rect.maxY + 1))
        path.addLine(to: CGPoint(x: rect.minX - 1, y: rect.maxY + 1))
        path.closeSubpath()
        
        return path
    }
}
