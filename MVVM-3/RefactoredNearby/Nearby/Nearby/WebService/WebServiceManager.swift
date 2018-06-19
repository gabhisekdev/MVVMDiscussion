//
//  WebServiceManager.swift
//  TravelTracker
//
//  Created by Abhisek on 08/01/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import UIKit

typealias WebServiceCompletionBlock = (_ data: [String:AnyObject]?,_ error: String?)->Void

struct WebServiceConstants {
    static let baseURL = "https://maps.googleapis.com/maps/api/place"
    static let placesAPI = "/nearbysearch/json?"
    static let imageAPI = "/photo?"
}

enum HTTPMethodType: Int {
    case POST = 0
    case GET
}

protocol WebServiceManagerProtocol {
    func requestAPI(url: String,parameter: [String: AnyObject]?, httpMethodType: HTTPMethodType, completion: @escaping WebServiceCompletionBlock)
}

class WebServiceManager: WebServiceManagerProtocol {
    
    func requestAPI(url: String,parameter: [String: AnyObject]?, httpMethodType: HTTPMethodType, completion: @escaping WebServiceCompletionBlock) {
        
        let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var request = URLRequest(url: URL(string: escapedAddress!)!)
        
        switch httpMethodType {
        case .POST:
            request.httpMethod = "POST"
        case .GET:
            request.httpMethod = "GET"
            
            if parameter != nil {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameter as Any, options: .prettyPrinted)
                } catch let error {
                    print(error.localizedDescription)
                    return
                }
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data, error == nil else {
                    completion(nil,"Something went wrong!")
                    return
                }
                
                // Check for http errors
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    completion(nil,"Error in fetching response")
                    return
                }
                
                do {
                    // Create json object from data
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        completion(json as [String : AnyObject],nil)
                    }
                } catch let error {
                    print(error.localizedDescription)
                    completion(nil,error.localizedDescription)
                }
                
            }
            task.resume()
            
        }
        
    }
    
}
