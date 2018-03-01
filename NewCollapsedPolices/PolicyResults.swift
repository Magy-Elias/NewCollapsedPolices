//
//  PolicyResults.swift
//  NewCollapsedPolices
//
//  Created by Mickey Goga on 2/25/18.
//  Copyright © 2018 Stanislav Ostrovskiy. All rights reserved.
//

import Foundation

public func dataFromFile(_ filename: String) -> Data? {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    if let path = bundle.path(forResource: filename, ofType: "json") {
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
    return nil
}

class Policies {
    var resultCode: Int?
    var errorKey: String?
    var resultItems = [ResultItems]()
    
    init?(data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                self.resultCode = json["resultCode"] as? Int
                self.errorKey = json["errorKey"] as? String
                
                if let resultItems = json["result"] as? [[String: Any]] {
                    self.resultItems = resultItems.map { ResultItems(json: $0) }
                }
            }
        } catch {
            print("Error deserializing JSON: \(error)")
            return nil
        }
    }
}

class ResultItems {
    var accessId: String?
    var isAnyTime: Bool?
    var range: Int?
    var repeatInterval: String?
    var on: [String]?
    var fromTime: String?
    var toTime: String?
    var startDate: String?
    var expirationDate: String?
    var startTime: String?
    var expirationTime: String?
    
    init(json: [String: Any]) {
        self.accessId = json["accessId"] as? String
        self.isAnyTime = json["isAnyTime"] as? Bool
        self.range = json["range"] as? Int
        self.repeatInterval = json["repeatInterval"] as? String
        self.on = json["on"] as? [String]
        
//        let fromTime = json["fromTime"] as? String
//        let toTime = json["toTime"] as? String
        let fromTime = json["fromTime"] as? String  //"13:15"
        let toTime = json["toTime"] as? String  //"13:15"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateFrom = dateFormatter.date(from: fromTime!)
        let dateTo = dateFormatter.date(from: toTime!)
        
//        dateFormatter.dateFormat = "HH:mm a"
        dateFormatter.dateFormat = "hh:mm a"
        self.fromTime = dateFormatter.string(from: dateFrom!)
        self.toTime = dateFormatter.string(from: dateTo!)
//        self.fromTime = json["fromTime"] as? String
//        self.toTime = json["toTime"] as? String
        
        
        let startDateString = json["startDate"] as? String
        let getStartDateTimeReturn = getStartExpireDateTimeString(dateString: startDateString!)
        self.startDate = getStartDateTimeReturn.date
        self.startTime = getStartDateTimeReturn.time
//        self.startDate = getDateFromString(dateString: startDateString!)
        print("startDate = \(String(describing: self.startDate))")
        print("startTime = \(String(describing: self.startTime))")
//        self.startDate = String(describing: getValidDate(from: startDateString!))
        let expireDateString = json["expirationDate"] as? String
        let getExpireDateTimeReturn = getStartExpireDateTimeString(dateString: expireDateString!)
        self.expirationDate = getExpireDateTimeReturn.date
        self.expirationTime = getExpireDateTimeReturn.time
//        self.expirationDate = getDateFromString(dateString: expireDateString!)
        print("expirationDate = \(String(describing: self.expirationDate))")
        print("expirationTime = \(String(describing: self.expirationTime))")
//        self.expirationDate = String(describing: getValidDate(from: expireDateString!))
    }
}

public func getStartExpireDateTimeString(dateString: String) -> (date: String?, time: String?) {
    var convertedDate: String = ""
    var convertedTime: String = ""
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let newDateFormatter = DateFormatter()
    newDateFormatter.dateFormat = "dd/MM/yyyy"
    
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "HH:mm:ss"
    let newTimeFormatter = DateFormatter()
    newTimeFormatter.dateFormat = "hh:mm a"

    let dateComponents = dateString.components(separatedBy: "T")
    let splitDate = dateComponents[0]
    let tempSplitTime = dateComponents[1].components(separatedBy: ".")
    let splitTime = tempSplitTime[0]
    
    if let date = dateFormatter.date(from: splitDate) {
        convertedDate = newDateFormatter.string(from: date)
    }
    
    if let time = timeFormatter.date(from: splitTime) {
        convertedTime = newTimeFormatter.string(from: time)
    }
    
    return ("\(convertedDate)", "\(convertedTime)")
}