//
//  Annotations.swift
//  Thirty
//
//  Created by Eric Terrisson on 21/04/2024.
//

import Foundation
import MapKit
import UIKit

class WaterAnnotationView: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        // Personnalisez l'apparence de votre annotation ici
        self.image = UIImage(systemName: "drop.fill")
        self.tintColor = .cyan
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UserLocationAnnotationView: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        // Personnalisez l'apparence de votre annotation ici
        self.image = UIImage(systemName: "person.fill")
        self.tintColor = .orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
