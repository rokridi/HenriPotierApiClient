//
//  Modelable.swift
//  HenriPotierApiClient
//
//  Created by Mohamed Aymen Landolsi on 07/03/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation

/// This protocol should be implemented by models representing JSON models.
protocol Modelable {
    
    associatedtype Model
    
    var model: Model {get}
}
