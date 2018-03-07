//
//  Offer.swift
//  HenriPotierApiClient
//
//  Created by Mohamed Aymen Landolsi on 07/03/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation

/// Represents an offer.
public struct Offer {
    
    /// Represents an offer type
    ///
    /// - percentage: type of the offer is percentage.
    /// - minus: type of the offer is minus.
    /// - slice: slice value.
    public enum OfferType: String {
        
        case percentage = "percentage"
        case minus = "minus"
        case slice = "slice"
    }
    
    /// Type of the offer.
    let type: OfferType
    
    /// value of the offer.
    let value: Int
    
    /// slice value.
    let sliceValue: Int?
}
