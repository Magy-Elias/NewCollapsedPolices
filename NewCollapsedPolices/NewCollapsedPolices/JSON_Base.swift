//
//  JSON_Base.swift
//  JsonTrial
//
//  Created by Mickey Goga on 2/21/18.
//  Copyright © 2018 Magy Elias. All rights reserved.
//

import Foundation

struct JSON_Base {
    
    let resultCode: Int?
    let errorKey: String?
    var results = [Result]()
    
    
    init?(json: JSON) {
//        guard let resultArray = json["result"] as? [JSON] else {
//            return nil
//        }
//        print(resultArray)
        
//        let resultObjects = resultArray.flatMap({ Result(json: $0) })
////        let resultObjects = resultArray.map({ Result(json: $0) })
//        self.results = resultObjects
//        print("\n\n\n\(resultObjects)\n\n\n")
        
        let resultCode = json["resultCode"] as? Int
        let errorKey = json["errorKey"] as? String
        if let resultItems = json["result"] as? [[String: Any]] {
            self.results = resultItems.map { Result(json: $0)! }
        }
        self.errorKey = errorKey
        self.resultCode = resultCode
    }
}
