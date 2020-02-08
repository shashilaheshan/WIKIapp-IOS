//
//  ApiService.swift
//  WIKIapp
//
//  Created by Shashila Heshan on 8/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiService {
    static func getDataFromWikiApi(query: String, completionHandler:@escaping (Bool, WikiModel?) -> ()) {
        
        
        AF.request( WIKI_API_BASE_URL+query,method: .get)
           .validate().responseJSON  { response in
                switch response.result {
                //if user does have a photo
                case .success(let value):
                    let json = JSON(value)
                    let image = json["thumbnail"].dictionary!["source"]?.stringValue
                    let data = WikiModel(title: json["title"].stringValue, thumbnail: image! , description: json["description"].stringValue, extract: json["extract"].stringValue)
                    completionHandler(true,data)
                   
                case .failure( _): break
                  
                }
        }
    }

}
