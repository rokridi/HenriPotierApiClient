//
//  HPApiBook.swift
//  HenriPotierApiClient
//
//  Created by Mohamed Aymen Landolsi on 07/03/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation

/// Represents a book model.
public struct HPApiBook {
    
    ///ISBN of the book.
    public let isbn: String
    
    /// Title of the book.
    public let title: String
    
    /// Price of the book.
    public let price: Int
    
    /// Book's cover URL.
    public let cover: String
    
    /// Synopsis of the book.
    public let synopsis: [String]
}
