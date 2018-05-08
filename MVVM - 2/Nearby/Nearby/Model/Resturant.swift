//
//  Restaurant.swift
//  Nearby
//
//  Created by Abhisek on 04/02/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import Foundation

struct Restaurant {
  
  var name: String?
  var address: String?
  var openStatus: String?
  var imageURL: String?
  
  init(attributes: [String: AnyObject]) {
    
    if let name = attributes["vicinity"] as? String {
      self.address = name
    }
    
    if let address = attributes["vicinity"] as? String {
      self.address = address
    }
    
    if let name = attributes["name"] as? String {
      self.name = name
    }
    
    if let openingAttribs = attributes["opening_hours"] as? [String: AnyObject] {
      if let isOpen = openingAttribs["open_now"] as? Bool {
        self.openStatus = isOpen ? "Opened" : "Closed"
      }
    }

    guard let photos = attributes["photos"] as? [[String: AnyObject]] else {return}
    guard photos.count>0 else {return}
    guard let photoReference = photos[0]["photo_reference"] as? String else { return }
    self.imageURL = WebServiceConstants.baseURL + WebServiceConstants.imageAPI + "maxwidth=400&" + "photoreference=\(photoReference)&key=\(googleApiKey)"
    
  }
  
}

