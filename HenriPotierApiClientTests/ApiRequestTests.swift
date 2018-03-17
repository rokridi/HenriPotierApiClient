//
//  ApiRequestTests.swift
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
import RxSwift

@testable import HenriPotierApiClient

class ApiRequestTests: QuickSpec {
    
    override func spec() {
        
        var apiClient: HenriPotierApiClient!
        var disposeBag: DisposeBag!
        
        beforeEach {
            apiClient = HenriPotierApiClient(baseURL: "http://domain.com")
            disposeBag = DisposeBag()
        }
        
        afterEach {
            disposeBag = nil
        }
        
        describe("Fetch books") {
            
            context("when response is OK", {
                
                it("should return a list of Book objects.", closure: {
                    
                    stub(condition: isHost("domain.com")) { request in
                        return OHHTTPStubsResponse(
                            fileAtPath: OHPathForFile("books.json", type(of: self))!,
                            statusCode: 200,
                            headers: ["Content-Type":"application/json"]
                        )
                    }
                    
                    waitUntil(action: { done in
                        
                        apiClient.books().subscribe(onNext: { books in
                            expect(books.count).to(equal(7))
                            done()
                        }).disposed(by: disposeBag)
                    })
                })
                
                context("when JSON is invalid", {
                    
                    it("should return a JSON error.", closure: {
                        
                        stub(condition: isHost("domain.com")) { request in
                            
                            return OHHTTPStubsResponse(
                                fileAtPath: OHPathForFile("invalid_books.json", type(of: self))!,
                                statusCode: 200,
                                headers: ["Content-Type":"application/json"]
                            )
                        }
                        
                        waitUntil(action: { done in
                            
                            apiClient.books().subscribe(onError: { error in
                                if case let ApiError.jsonMappingFailed(error: error) = error {
                                    expect(error).toNot(beNil())
                                } else {
                                    fail("Error should be jsonMappingFailed.")
                                }
                                done()
                            }).disposed(by: disposeBag)
                        })
                    })
                })
                
                context("when response code is invalid", {
                    
                    it("should return a responseValidationFailed error with reason unacceptableStatusCode code 400.", closure: {
                        
                        stub(condition: isHost("domain.com")) { request in
                            
                            return OHHTTPStubsResponse(
                                fileAtPath: OHPathForFile("invalid_books.json", type(of: self))!,
                                statusCode: 400,
                                headers: ["Content-Type":"application/json"]
                            )
                        }
                        
                        waitUntil(action: { done in
                            
                            apiClient.books().subscribe(onError: { error in
                                if case let ApiError.responseValidationFailed(reason: .unacceptableStatusCode(code: code)) = error {
                                    expect(code).to(equal(400))
                                } else {
                                    fail("Error should be responseValidationFailed with reason unacceptableStatusCode code 400.")
                                }
                                done()
                            }).disposed(by: disposeBag)
                        })
                    })
                })
                
                context("when received content type is invalid.", {
                    it("should return a responseValidationFailed error with reason unacceptableContentType with responseContentType: application/xml.", closure: {
                        
                        stub(condition: isHost("domain.com")) { request in
                            
                            return OHHTTPStubsResponse(
                                fileAtPath: OHPathForFile("books.json", type(of: self))!,
                                statusCode: 200,
                                headers: ["Content-Type":"application/xml"]
                            )
                        }
                        
                        waitUntil(action: { done in
                            apiClient.books().subscribe(onError: { error in
                                if case let ApiError.responseValidationFailed(reason: .unacceptableContentType(acceptableContentTypes: _, responseContentType: received)) = error {
                                    expect(received).to(equal("application/xml"))
                                } else {
                                    fail("Error should be responseValidationFailed with reason unacceptableContentType.")
                                }
                                done()
                            }).disposed(by: disposeBag)
                        })
                    })
                })
            })
        }
        
        describe("Fetch offers") {
            
            context("when response is OK", {
                
                it("should return a list of Offer objects.", closure: {
                    
                    stub(condition: isHost("domain.com")) { request in
                        return OHHTTPStubsResponse(
                            fileAtPath: OHPathForFile("offers.json", type(of: self))!,
                            statusCode: 200,
                            headers: ["Content-Type":"application/json"]
                        )
                    }
                    
                    waitUntil(action: { done in
                        
                        apiClient.offers(ISBNs: ["c8fabf68-8374-48fe-a7ea-a00ccd07afff", "a460afed-e5e7-4e39-a39d-c885c05db861"]).subscribe(onNext: {offers in
                            expect(offers.count).to(equal(3))
                            if offers.count == 3 {
                                expect(offers.first!.type).to(equal(HPApiOffer.OfferType.percentage))
                                expect(offers.first!.value).to(equal(4))
                                expect(offers.first!.sliceValue).to(beNil())
                                
                                expect(offers[1].type).to(equal(HPApiOffer.OfferType.minus))
                                expect(offers[1].value).to(equal(15))
                                expect(offers[1].sliceValue).to(beNil())
                                
                                expect(offers.last!.type).to(equal(HPApiOffer.OfferType.slice))
                                expect(offers.last!.value).to(equal(12))
                                expect(offers.last!.sliceValue).to(equal(100))
                            }
                            done()
                        }).disposed(by: disposeBag)
                    })
                })
                
                context("when JSON is invalid", {
                    
                    it("should return a JSON error.", closure: {
                        
                        stub(condition: isHost("domain.com")) { request in
                            
                            return OHHTTPStubsResponse(
                                fileAtPath: OHPathForFile("invalid_offers.json", type(of: self))!,
                                statusCode: 200,
                                headers: ["Content-Type":"application/json"]
                            )
                        }
                        
                        waitUntil(action: { done in
                            apiClient.offers(ISBNs: ["c8fabf68-8374-48fe-a7ea-a00ccd07afff", "a460afed-e5e7-4e39-a39d-c885c05db861"]).subscribe(onError: { error in
                                if case let ApiError.jsonMappingFailed(error: error) = error {
                                    expect(error).toNot(beNil())
                                } else {
                                    fail("Error should be jsonMappingFailed.")
                                }
                                
                                done()
                            }).disposed(by: disposeBag)
                        })
                    })
                })
                
                context("when response code is invalid", {
                    
                    it("should return a responseValidationFailed error with reason unacceptableStatusCode code 400.", closure: {
                        
                        stub(condition: isHost("domain.com")) { request in
                            
                            return OHHTTPStubsResponse(
                                fileAtPath: OHPathForFile("offers.json", type(of: self))!,
                                statusCode: 400,
                                headers: ["Content-Type":"application/json"]
                            )
                        }
                        
                        waitUntil(action: { done in
                            apiClient.offers(ISBNs: ["c8fabf68-8374-48fe-a7ea-a00ccd07afff", "a460afed-e5e7-4e39-a39d-c885c05db861"]).subscribe(onError: { error in
                                if case let ApiError.responseValidationFailed(reason: .unacceptableStatusCode(code: code)) = error {
                                    expect(code).to(equal(400))
                                } else {
                                    fail("Error should be responseValidationFailed with reason unacceptableStatusCode code 400.")
                                }
                                
                                done()
                            }).disposed(by: disposeBag)
                        })
                    })
                    
                    context("when received content type is invalid.", {
                        it("should return a responseValidationFailed error with reason unacceptableContentType with responseContentType: application/xml.", closure: {
                            
                            stub(condition: isHost("domain.com")) { request in
                                
                                return OHHTTPStubsResponse(
                                    fileAtPath: OHPathForFile("offers.json", type(of: self))!,
                                    statusCode: 200,
                                    headers: ["Content-Type":"application/xml"]
                                )
                            }
                            
                            waitUntil(action: { done in
                                apiClient.offers(ISBNs: ["c8fabf68-8374-48fe-a7ea-a00ccd07afff", "a460afed-e5e7-4e39-a39d-c885c05db861"]).subscribe(onError: { error in
                                    if case let ApiError.responseValidationFailed(reason: .unacceptableContentType(acceptableContentTypes: _, responseContentType: received)) = error {
                                        expect(received).to(equal("application/xml"))
                                    } else {
                                        fail("Error should be unacceptableContentType with received content type application/xml.")
                                    }
                                    
                                    done()
                                }).disposed(by: disposeBag)
                            })
                        })
                    })
                })
            })
        }
    }
}

