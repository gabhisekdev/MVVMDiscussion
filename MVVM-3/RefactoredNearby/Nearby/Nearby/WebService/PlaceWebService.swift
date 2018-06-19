//
//  RestaurantWebServices.swift
//  Nearby
//
//  Created by Abhisek on 04/02/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation

struct PlaceWebService {
    
    func getPlaceList(manager: WebServiceManagerProtocol, placeType: PlaceType, completion: @escaping ([Place]?, _ error: String?)->()) {
        let userLat = String(format:"%3f", LocationManager.sharedManager.latitude)
        let userLong = String(format:"%3f", LocationManager.sharedManager.longitude)
        
        let url = WebServiceConstants.baseURL + WebServiceConstants.placesAPI + "location=\(userLat),\(userLong)&radius=200&type=\(placeType.rawValue)&key=\(googleApiKey)"
        manager.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, errorMessage) in
            guard let data = response else {
                completion(nil, errorMessage)
                return
            }
            guard let results = data["results"] as? [[String: Any]] else { return }
            completion(self.placesListFrom(placeType: placeType, results: results), nil)
        }
    }
    
    private func placesListFrom(placeType: PlaceType, results: [[String: Any]]) -> [Place] {
        var places = [Place]()
        for place in results {
           places.append(Place(attributes: place, type: placeType))
        }
        return places
    }
    
    
}
