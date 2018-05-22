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
        let places = AppData.sharedData.appData.filter { $0.type == paceType }.sorted { $0.rating! > $1.rating! }
        return Array(places.prefix(topPlacesCount))
    }
    
}
