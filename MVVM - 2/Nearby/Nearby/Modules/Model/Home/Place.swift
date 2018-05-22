//
//  Place.swift
//  Nearby
//
//  Created by Abhisek on 13/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation
import CoreLocation

enum PlaceType: String {
    case resturant = "resturant"
    case atm = "atm"
    case nightClub = "night_club"
    case cafe = "cafe"
    
    static func allPlaceType() -> [PlaceType] {
        return [.resturant, .atm, .nightClub, .cafe]
    }
    
    func iconUrl() -> String {
        switch self {
        case .resturant:
            return "https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png"
        case .atm:
            return "https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png"
        case .nightClub:
            return "https://maps.gstatic.com/mapfiles/place_api/icons/bar-71.png"
        case .cafe:
            return "https://maps.gstatic.com/mapfiles/place_api/icons/cafe-71.png"
        }
    }
    
    func displayText() -> String {
        switch self {
        case .resturant:
            return "Resturant"
        case .atm:
            return "ATM"
        case .nightClub:
            return "Night Club"
        case .cafe:
            return "Cafe"
        }
    }
    
}

struct Place {
    
    var name: String?
    var address: String?
    var location: CLLocation?
    var type: PlaceType!
    var imageURL: String?
    var rating: Double?
    
    init(attributes: [String: Any], type: PlaceType) {
        self.type = type
        
        if let name = attributes["vicinity"] as? String {
            self.address = name
        }
        
        if let name = attributes["name"] as? String {
            self.name = name
        }
        
        if let rating = attributes["rating"] as? Double {
            self.rating = rating
        }
        
        guard let geometry = attributes["geometry"] as? [String: Any], let location = geometry["location"] as? [String: Any],let lat = location["lat"] as? Double, let long = location["long"] as? Double else { return }
        self.location = CLLocation(latitude: lat, longitude: long)
        
        guard let photos = attributes["photos"] as? [[String: AnyObject]] else {return}
        guard photos.count>0 else {return}
        guard let photoReference = photos[0]["photo_reference"] as? String else { return }
        self.imageURL = WebServiceConstants.baseURL + WebServiceConstants.imageAPI + "maxwidth=200&" + "photoreference=\(photoReference)&key=\(googleApiKey)"
        
    }
    
}
