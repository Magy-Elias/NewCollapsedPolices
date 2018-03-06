//
//  DataService.swift
//  JsonTrial
//
//  Created by Mickey Goga on 2/21/18.
//  Copyright © 2018 Magy Elias. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

class DataService {
    
    private init() {}
    static let shared = DataService()
    
    func getData(completion: (Data) -> Void) {
        guard let path = Bundle.main.path(forResource: "ServerData", ofType: "json") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            completion(data)
        } catch {
            print(error)
        }
    }
}
