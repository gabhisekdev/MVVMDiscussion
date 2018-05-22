//
//  PlaceViewVM.swift
//  Nearby
//
//  Created by Abhisek on 14/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation
import CoreLocation

protocol PlaceViewVMRepresentable {
    // Output
    var placeImageUrl: String { get }
    var name: String { get }
    var distance: Double { get }
    
    // Input
    func placesViewPressed()
    
    // Event
    var placesViewTapped: () -> () { get }
}


class PlaceViewVM: PlaceViewVMRepresentable {
    // Output
    var placeImageUrl: String = ""
    var name: String = ""
    var distance: Double = 0.0
    
    // Data Model
    private var place: Place!
    
    // Event
    var placesViewTapped: () -> () = { }
    
    init(place: Place) {
        self.place = place
        placeImageUrl = place.imageURL ?? ""
        name = place.name!
        let currentLocation = CLLocation(latitude: LocationManager.sharedManager.latitude, longitude: LocationManager.sharedManager.longitude)
        distance = place.location?.distance(from: currentLocation) ?? 0.0
    }
    
    func placesViewPressed() {
        placesViewTapped()
    }
    
}
