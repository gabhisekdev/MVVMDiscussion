//
//  Helper.swift
//  Nearby
//
//  Created by Abhisek on 15/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation

class Helper {
    
    static func getTopPlace(paceType: PlaceType, topPlacesCount: Int) -> [Place] {
        let places = AppData.sharedData.allPlaces.filter { $0.type == paceType }.sorted {
            guard let rating1 = $0.rating, let rating2 = $1.rating else { return false }
            return rating1 > rating2
        }
        return Array(places.prefix(topPlacesCount))
    }
    
}
