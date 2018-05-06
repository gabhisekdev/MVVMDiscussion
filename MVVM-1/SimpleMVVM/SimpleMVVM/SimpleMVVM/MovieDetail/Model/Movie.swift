//
//  Movie.swift
//  SimpleMVVM
//
//  Created by Abhisek on 06/05/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation

struct Movie {
    var movieName = ""
    var movieImageName = ""
    var isFavorite = false
    var director = ""
    var releaseDate = Date()
    var income = "$0.0"
    var rating = 0.0
    
    init(data: [String: Any]) {
        movieName = data["movieName"] as! String
        movieImageName = data["movieImageName"] as! String
        isFavorite = data["isFavorite"] as! Bool
        director = data["director"] as! String
        releaseDate = data["releaseDate"] as! Date
        income = data["income"] as! String
        rating = data["rating"] as! Double
    }
}
