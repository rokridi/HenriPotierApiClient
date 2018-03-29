//
//  HenriPotierApiClient.swift
//  HenriPotierApiClient
//
//  Created by Mohamed Aymen Landolsi on 07/03/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import AlamofireObjectMapper

/// Class for managing Henri Potier Api calls.
public class HenriPotierApiClient {
    
    private let baseURL: String
    private let sessionManager: SessionManager
    
    /// Create a HenriPotierApiClient instance.
    ///
    /// - Parameters:
    ///   - configuration: URLSessionConfiguration. Default value is URLSessionConfiguration.default.
    ///   - baseURL: the base URL of the remote server.
    public init(configuration: URLSessionConfiguration = URLSessionConfiguration.default, baseURL: String) {
        sessionManager = SessionManager(configuration: configuration)
        self.baseURL = baseURL
    }
}

//MARK: - API

public extension HenriPotierApiClient {
    
    /// Get books.
    ///
    /// - Returns: Observable<[HPApiBook]>.
    
    @discardableResult public func books() -> Observable<[HPApiBook]> {
        return Observable.create({ observer -> Disposable in
            let dataTask = self.sessionManager.request(ApiRouter.books(self.baseURL))
                .validate()
                .validate(contentType: ["application/json"])
                .responseArray(completionHandler: { (response:DataResponse<[Book]>) in
                    switch response.result {
                    case .success(let apiBooks):
                        observer.onNext(apiBooks.map({ $0.model }))
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error.apiError)
                    }
                })
            
            return Disposables.create {
                dataTask.cancel()
            }
        })
    }
    
    /// Get offers for list of books (represented by their ISBNs).
    ///
    /// - Parameters:
    ///   - ISBNs: ISBNs of the books.
    /// - Returns: Observable<[HPApiOffer]>.
    
    @discardableResult public func offers(ISBNs: [String]) -> Observable<[HPApiOffer]> {
        return Observable.create({ observer -> Disposable in
            let dataTask = self.sessionManager.request(ApiRouter.offers(ISBNs, self.baseURL))
                .validate()
                .validate(contentType: ["application/json"])
                .responseArray(keyPath:"offers", completionHandler: { (response:DataResponse<[Offer]>) in
                    switch response.result {
                    case .success(let offers):
                        observer.onNext(offers.map({ $0.model }))
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error.apiError)
                    }
                })
            
            return Disposables.create {
                dataTask.cancel()
            }
        })
    }
}
