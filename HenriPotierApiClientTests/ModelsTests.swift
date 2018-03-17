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
                it("should be a valid Book", closure: {
                    let mapper = Mapper<Book>()
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
                it("should be a non valid Book", closure: {
                    let mapper = Mapper<Book>()
                    let json = Helpers.JSONFromFile("invalid_book")
                    let book = try? mapper.map(JSONObject: json as Any)
                    
                    expect(book).to(beNil())
                })
            })
        }
        
        describe("HPApiBook") {
            
            it("should be a valid HPApiBook", closure: {
                
                let synopsis = [
                    "Henri rentre en sixième année à l'école de sorcellerie Poudlard. Il entre alors en possession d'un livre de potion portant le mot « propriété du Prince de sang-mêlé » et commence à en savoir plus sur le sombre passé de Voldemort qui était encore connu sous le nom de Tom Jedusor."
                ]
                
                let book = HPApiBook(isbn: "cef179f2-7cbc-41d6-94ca-ecd23d9f7fd6", title: "Henri Potier et le Prince de sang-mêlé", price: 30, cover: "http://henri-potier.xebia.fr/hp5.jpg", synopsis: synopsis)
                
                expect(book.isbn).to(equal("cef179f2-7cbc-41d6-94ca-ecd23d9f7fd6"))
                expect(book.title).to(equal("Henri Potier et le Prince de sang-mêlé"))
                expect(book.price).to(equal(30))
                expect(book.cover).to(equal("http://henri-potier.xebia.fr/hp5.jpg"))
            })
        }
        
        describe("Offer") {
            
            context("when JSON is valid", {
                it("should be a percentage offer", closure: {
                    let mapper = Mapper<Offer>()
                    let json = Helpers.JSONFromFile("percentage_offer")
                    
                    let apiOffer = try? mapper.map(JSONObject: json as Any)
                    
                    expect(apiOffer).toNot(beNil())
                    
                    if let apiOffer = apiOffer {
                        expect(apiOffer.type).to(equal(HPApiOffer.OfferType.percentage))
                        expect(apiOffer.value).to(equal(4))
                        expect(apiOffer.sliceValue).to(beNil())
                        
                        let offer = apiOffer.model
                        expect(offer.type).to(equal(HPApiOffer.OfferType.percentage))
                        expect(offer.value).to(equal(4))
                        expect(offer.sliceValue).to(beNil())
                    }
                })
                
                it("should be a minus offer", closure: {
                    let mapper = Mapper<Offer>()
                    let json = Helpers.JSONFromFile("minus_offer")
                    let apiOffer = try? mapper.map(JSONObject: json as Any)
                    
                    expect(apiOffer).toNot(beNil())
                    
                    if let apiOffer = apiOffer {
                        expect(apiOffer.type).to(equal(HPApiOffer.OfferType.minus))
                        expect(apiOffer.value).to(equal(15))
                        expect(apiOffer.sliceValue).to(beNil())
                        
                        let offer = apiOffer.model
                        expect(offer.type).to(equal(HPApiOffer.OfferType.minus))
                        expect(offer.value).to(equal(15))
                        expect(offer.sliceValue).to(beNil())
                    }
                })
                
                it("should be a slice offer", closure: {
                    let mapper = Mapper<Offer>()
                    let json = Helpers.JSONFromFile("slice_offer")
                    let apiOffer = try? mapper.map(JSONObject: json as Any)
                    
                    expect(apiOffer).toNot(beNil())
                    
                    if let apiOffer = apiOffer {
                        expect(apiOffer.type).to(equal(HPApiOffer.OfferType.slice))
                        expect(apiOffer.value).to(equal(12))
                        expect(apiOffer.sliceValue).to(equal(100))
                        
                        let offer = apiOffer.model
                        expect(offer.type).to(equal(HPApiOffer.OfferType.slice))
                        expect(offer.value).to(equal(12))
                        expect(offer.sliceValue).to(equal(100))
                    }
                })
            })
            
            context("when JSON is not valid", {
                it("should be a non valid HPApiOffer", closure: {
                    let mapper = Mapper<Offer>()
                    let json = Helpers.JSONFromFile("invalid_offer")
                    let apiOffer = try? mapper.map(JSONObject: json as Any)
                    
                    expect(apiOffer).to(beNil())
                })
            })
        }
    }
}
