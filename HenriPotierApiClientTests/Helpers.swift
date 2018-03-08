//
//  Helpers.swift
//  HenriPotierApiClientTests
//
//  Created by Mohamed Aymen Landolsi on 07/03/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import OHHTTPStubs
import ObjectMapper

class Helpers {
    
    static func JSONFromFile(_ file: String) -> [String: Any]? {
        
        let bundle = Bundle(for: Helpers.self)
        let file = bundle.url(forResource: file, withExtension: "json")!
        
        do {
            let data = try Data(contentsOf: file)
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return dictionary as? [String : Any]
        } catch {
            return nil
        }
    }
}
