//
//  Result.swift
//  JsonTrial
//
//  Created by Mickey Goga on 2/21/18.
//  Copyright © 2018 Magy Elias. All rights reserved.
//

import Foundation

struct Result {
    
    let accessId: String
    let isAnyTime: Bool
    let range: Int
    let repeatInterval: String
    let on: [String?]
    let startDate: String
    let expirationDate: String
    let fromTime: String
    let toTime: String
    
    
    
    init?(json: JSON) {
//        guard let result = json["result"] as? JSON else {
//            return nil
//        }
        guard let accessId = json["accessId"] as? String, let isAnyTime = json["isAnyTime"] as? Bool,
            let range = json["range"] as? Int, let repeatInterval = json["repeatInterval"] as? String, let on = json["on"] as? [String], let startDate = json["startDate"] as? String, let expirationDate = json["expirationDate"] as? String, let fromTime = json["fromTime"] as? String, let toTime = json["toTime"] as? String else {
                return nil
        }
        
        self.accessId = accessId
        self.isAnyTime = isAnyTime
        self.range = range
        self.repeatInterval = repeatInterval
        self.on = on
        self.startDate = startDate
        self.expirationDate = expirationDate
        self.fromTime = fromTime
        self.toTime = toTime
//        print(json)
    }
}
