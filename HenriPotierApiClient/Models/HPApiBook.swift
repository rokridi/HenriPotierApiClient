//
//  HPApiBook.swift
//  HenriPotierApiClient
//
//  Created by Mohamed Aymen Landolsi on 07/03/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import ObjectMapper

/// Api book model.
struct HPApiBook: ImmutableMappable {
    
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
    
    init(map: Map) throws {
        isbn = try map.value("isbn")
        title = try map.value("title")
        price = try map.value("price")
        cover = try map.value("cover")
        synopsis = try map.value("synopsis")
    }
}

extension HPApiBook: Modelable {
    
    typealias Model = Book
    
    var model: Book {
        return Book(isbn: isbn, title: title, price: price, cover: cover, synopsis: synopsis)
    }
}
