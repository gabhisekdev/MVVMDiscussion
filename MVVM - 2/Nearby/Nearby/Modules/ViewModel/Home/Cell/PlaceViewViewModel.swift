//
//  PlaceViewViewModel.swift
//  Nearby
//
//  Created by Abhisek on 14/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation
import CoreLocation

protocol PlaceViewViewModelRepresentable {
    // Output
    var placeImageUrl: String { get }
    var name: String { get }
    var distance: String { get }
    
    // Input
    func placesViewPressed()
    
    // Event
    var placesViewSelected: () -> () { get }
}


class PlaceViewViewModel: PlaceViewViewModelRepresentable {
    // Output
    var placeImageUrl: String = ""
    var name: String = ""
    var distance: String = ""
    
    // Data Model
    private var place: Place!
    
    // Event
    var placesViewSelected: () -> () = { }
    
    init(place: Place) {
        self.place = place
        configureOutput()
    }
    
    private func configureOutput() {
        placeImageUrl = place.imageURL ?? ""
        name = place.name ?? ""
        let currentLocation = CLLocation(latitude: LocationManager.sharedManager.latitude, longitude: LocationManager.sharedManager.longitude)
        guard let distance = place.location?.distance(from: currentLocation) else { return }
        self.distance = String(format: "%.2f mi", distance/1609.344)
    }
    
    func placesViewPressed() {
        placesViewSelected()
    }
    
}
