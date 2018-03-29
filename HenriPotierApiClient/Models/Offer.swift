//
//  Offer.swift
//  HenriPotierApiClient
//
//  Created by Mohamed Aymen Landolsi on 07/03/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import ObjectMapper

/// Represents an offer API model.
struct Offer: Mappable {
    
    var type: HPApiOffer.OfferType = .percentage
    var value: Int = 0
    var sliceValue: Int?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        type <- (map["type"],EnumTransform<HPApiOffer.OfferType>())
        value <- map["value"]
        sliceValue <- map["sliceValue"]
    }
}

extension Offer: Modelable {
    
    typealias Model = HPApiOffer
    
    var model: HPApiOffer {
        return HPApiOffer(type: type, value: value, sliceValue: sliceValue)
    }
}
