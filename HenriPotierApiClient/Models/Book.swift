//
//  Book.swift
//  HenriPotierApiClient
//
//  Created by Mohamed Aymen Landolsi on 07/03/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation

/// Represents a book model.
public struct Book {
    
    ///ISBN of the book.
    let isbn: String
    
    /// Title of the book.
    let title: String
    
    /// Price of the book.
    let price: Int
    
    /// Book's cover URL.
    let cover: String
    
    /// Synopsis of the book.
    let synopsis: [String]
}
