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
struct Offer: ImmutableMappable {
    
    let type: HPApiOffer.OfferType
    let value: Int
    let sliceValue: Int?
    
    init(map: Map) throws {
        type = try map.value("type", using: EnumTransform<HPApiOffer.OfferType>())
        value = try map.value("value")
        sliceValue = try? map.value("sliceValue")
    }
}

extension Offer: Modelable {
    
    typealias Model = HPApiOffer
    
    var model: HPApiOffer {
        return HPApiOffer(type: type, value: value, sliceValue: sliceValue)
    }
}
