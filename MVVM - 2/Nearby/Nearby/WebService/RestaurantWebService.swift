//
//  RestaurantWebServices.swift
//  Nearby
//
//  Created by Abhisek on 04/02/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation

struct RestaurantWebService {
  
  func getRestaurantList(completion: @escaping ([Restaurant]?, _ error: Error?)->()) {
    
    let userLat = String(format:"%3f", LocationManager.sharedManager.latitude)
    let userLong = String(format:"%3f", LocationManager.sharedManager.longitude)
    
    let url = WebServiceConstants.baseURL + WebServiceConstants.placesAPI + "location=\(userLat),\(userLong)&radius=200&type=restaurant&key=\(googleApiKey)"
    WebServiceManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
      
      guard let data = response else {
        completion(nil, error)
        return
      }
      
      var resturantList = [Restaurant]()
      if let resturants = data["results"] as? [[String: Any]] {
        for resturant in resturants {
          if resturantList.count > 10 {
            completion(resturantList, nil)
            return
          }
          resturantList.append(Restaurant(attributes: resturant as [String : AnyObject]))
        }
        completion(resturantList, nil)
      }
      
    }
  }
  
  
}
