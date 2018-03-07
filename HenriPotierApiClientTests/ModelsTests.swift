//
//  ModelsTests.swift
//  HenriPotierApiClientTests
//
//  Created by Mohamed Aymen Landolsi on 07/03/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import ObjectMapper
import OHHTTPStubs

@testable import HenriPotierApiClient

class ModelsTests: QuickSpec {
    
    override func spec() {
        
        describe("HPApiBook") {
            
            context("when JSON is valid", {
                it("should be a valid HPApiBook", closure: {
                    let mapper = Mapper<HPApiBook>()
                    let json = Helpers.JSONFromFile("book")
                    let apiBook = try? mapper.map(JSONObject: json as Any)
                    
                    expect(apiBook).toNot(beNil())
                    
                    if apiBook != nil {
                        expect(apiBook!.isbn).to(equal("cef179f2-7cbc-41d6-94ca-ecd23d9f7fd6"))
                        expect(apiBook!.title).to(equal("Henri Potier et le Prince de sang-mêlé"))
                        expect(apiBook!.price).to(equal(30))
                        expect(apiBook!.cover).to(equal("http://henri-potier.xebia.fr/hp5.jpg"))
                        
                        let synopsis = [
                            "Henri rentre en sixième année à l'école de sorcellerie Poudlard. Il entre alors en possession d'un livre de potion portant le mot « propriété du Prince de sang-mêlé » et commence à en savoir plus sur le sombre passé de Voldemort qui était encore connu sous le nom de Tom Jedusor."
                        ]
                        
                        expect(apiBook!.synopsis).to(equal(synopsis))
                        
                        let book = apiBook!.model
                        expect(book.isbn).to(equal("cef179f2-7cbc-41d6-94ca-ecd23d9f7fd6"))
                        expect(book.title).to(equal("Henri Potier et le Prince de sang-mêlé"))
                        expect(book.price).to(equal(30))
                        expect(book.cover).to(equal("http://henri-potier.xebia.fr/hp5.jpg"))
                    }
                })
            })
            
            context("when JSON is not valid", {
                it("should be a non valid HPApiBook", closure: {
                    let mapper = Mapper<HPApiBook>()
                    let json = Helpers.JSONFromFile("invalid_book")
                    let book = try? mapper.map(JSONObject: json as Any)
                    
                    expect(book).to(beNil())
                })
            })
        }
        
        describe("Book") {
            
            it("should be a valid book", closure: {
                
                let synopsis = [
                    "Henri rentre en sixième année à l'école de sorcellerie Poudlard. Il entre alors en possession d'un livre de potion portant le mot « propriété du Prince de sang-mêlé » et commence à en savoir plus sur le sombre passé de Voldemort qui était encore connu sous le nom de Tom Jedusor."
                ]
                
                let book = Book(isbn: "cef179f2-7cbc-41d6-94ca-ecd23d9f7fd6", title: "Henri Potier et le Prince de sang-mêlé", price: 30, cover: "http://henri-potier.xebia.fr/hp5.jpg", synopsis: synopsis)
                
                expect(book.isbn).to(equal("cef179f2-7cbc-41d6-94ca-ecd23d9f7fd6"))
                expect(book.title).to(equal("Henri Potier et le Prince de sang-mêlé"))
                expect(book.price).to(equal(30))
                expect(book.cover).to(equal("http://henri-potier.xebia.fr/hp5.jpg"))
            })
        }
    }
}
