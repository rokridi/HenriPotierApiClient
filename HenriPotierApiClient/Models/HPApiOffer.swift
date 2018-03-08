//
//  HPApiOffer.swift
//  HenriPotierApiClient
//
//  Created by Mohamed Aymen Landolsi on 07/03/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import ObjectMapper

struct HPApiOffer: ImmutableMappable {
    
    let type: Offer.OfferType
    let value: Int
    let sliceValue: Int?
    
    init(map: Map) throws {
        type = try map.value("type", using: EnumTransform<Offer.OfferType>())
        value = try map.value("value")
        sliceValue = try? map.value("sliceValue")
    }
}

extension HPApiOffer: Modelable {
    
    typealias Model = Offer
    
    var model: Offer {
        return Offer(type: type, value: value, sliceValue: sliceValue)
    }
}
