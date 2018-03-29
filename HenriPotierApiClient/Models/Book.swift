//
//  Book.swift
//  HenriPotierApiClient
//
//  Created by Mohamed Aymen Landolsi on 07/03/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import ObjectMapper

/// Api book model.
struct Book: Mappable {
    
    ///ISBN of the book.
    var isbn: String = ""
    
    /// Title of the book.
    var title: String = ""
    
    /// Price of the book.
    var price: Int = 0
    
    /// Book's cover URL.
    var cover: String = ""
    
    /// Synopsis of the book.
    var synopsis: [String] = []
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        isbn <- map["isbn"]
        title <- map["title"]
        price <- map["price"]
        cover <- map["cover"]
        synopsis <- map["synopsis"]
    }
}

extension Book: Modelable {
    
    typealias Model = HPApiBook
    
    var model: HPApiBook {
        return HPApiBook(isbn: isbn, title: title, price: price, cover: cover, synopsis: synopsis)
    }
}
