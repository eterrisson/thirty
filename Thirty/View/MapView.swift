//
//  MapView.swift
//  Thirty
//
//  Created by Eric Terrisson on 22/04/2024.
//

import SwiftUI
import MapKit

 struct MapView: UIViewRepresentable {
 
 
     var location: CLLocationCoordinate2D
     
     @Binding var title: String
     @Binding var address: String
     @Binding var distance: Double
     @Binding var travelTime: Double
     
     @Binding var isButtonHidden: Bool
     
     func makeUIView(context: Context) -> MKMapView {
         let mapView = MKMapView(frame: .zero)
         mapView.delegate = context.coordinator
         
         //Tracking Mode
         mapView.userTrackingMode = .followWithHeading
         
         return mapView
     }
     
     func updateUIView(_ uiView: MKMapView, context: Context) {
         // Régler la région de la carte pour afficher la position
         let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
         let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
         let region = MKCoordinateRegion(center: coordinate, span: span)
         uiView.setRegion(region, animated: true)
         
         // add water annotations
         searchForWaterNearby(at: coordinate) { mapItems, error in
             if let error = error {
                 print("Error searching for water: \(error.localizedDescription)")
             } else {
                 addAnnotations(for: mapItems, to: uiView)
             }
         }
     }
     
     func searchForWaterNearby(at coordinate: CLLocationCoordinate2D, completion: @escaping ([MKMapItem]?, Error?) -> Void) {
         let request = MKLocalSearch.Request()
         request.naturalLanguageQuery = "drinking fountain"
         request.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000) // Définir la région de recherche à proximité de l'utilisateur
         
         let search = MKLocalSearch(request: request)
         search.start { (response, error) in
             completion(response?.mapItems, error)
         }
     }
     
     func addAnnotations(for mapItems: [MKMapItem]?, to mapView: MKMapView) {
         guard let mapItems = mapItems else { return }
         for item in mapItems {
         
             let annotation = MKPointAnnotation()
             annotation.coordinate = item.placemark.coordinate
             annotation.title = item.name
             annotation.subtitle = item.placemark.title // Utiliser le titre du placemark comme adresse
             mapView.addAnnotation(annotation)
             }
         }
         
     func makeCoordinator() -> Coordinator {
         Coordinator(mapView: self)
     }
         
     class Coordinator: NSObject, MKMapViewDelegate {
         var title: String = ""
         var address: String = ""
         
         var mapView: MapView?
         
         init(mapView: MapView) {
             self.mapView = mapView
         }
     
         func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
             // Supprimer le overlay existant
             mapView.removeOverlays(mapView.overlays)
             
             guard let annotation = view.annotation else { return }
                 if let title = annotation.title {
                     self.title = title!
                 if let address = annotation.subtitle {
                     self.address = address!
                 }
             }
         
             // Mettre à jour les propriétés de MapView
             self.mapView?.title = title
             self.mapView?.address = address
         
             // Direction
             let request = MKDirections.Request()
             request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.mapView!.location ))
             request.destination = MKMapItem(placemark: MKPlacemark(coordinate: annotation.coordinate ))
             request.transportType = .walking
             
             let directions = MKDirections(request: request)
             directions.calculate { response, error in
                 guard let route = response?.routes.first else { return }
                 mapView.addOverlay(route.polyline) // Utilisez mapView au lieu de self.mapView
                 
                 // Récupérer la distance et la durée du trajet
                 let distance = route.distance // en mètres
                 let travelTime = route.expectedTravelTime // en secondes
                 
                 // Mettre à jour les propriétés de MapView
                 self.mapView?.distance = distance
                 self.mapView?.travelTime = travelTime
             }
         
             // Display itinary button
             self.mapView?.isButtonHidden = false
             
             mapView.userTrackingMode = .followWithHeading
         }
     
         func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
             let renderer = MKPolylineRenderer(overlay: overlay)
             renderer.strokeColor = .blue
             renderer.lineWidth = 5
             return renderer
         }
     
         func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
             if annotation is MKUserLocation {
                 return nil
             }
             var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
             
             if annotationView == nil {
                 annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
             } else {
                 annotationView?.annotation = annotation
             }
             
             annotationView?.image = UIImage(named: "pinwater")
             
             return annotationView
         }
     }
 }
