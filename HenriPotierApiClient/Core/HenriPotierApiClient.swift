//
//  HenriPotierApiClient.swift
//  HenriPotierApiClient
//
//  Created by Mohamed Aymen Landolsi on 07/03/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

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
    
    /// Get list of books.
    ///
    /// - Parameters:
    ///   - queue: queue on which completion will be called when the task is finished.
    ///   - completion: closure called when task is finished.
    /// - Returns: URLSessionTask.
    @discardableResult public func books(queue: DispatchQueue = DispatchQueue.main , completion: @escaping (Result<[Book]>) -> Void) -> URLSessionTask? {
        let dataRequest = sessionManager.request(ApiRouter.books(baseURL))
            .validate()
            .validate(contentType: ["application/json"])
            .responseArray(completionHandler: { (response:DataResponse<[HPApiBook]>) in
                
                switch response.result {
                case .success(let apiBooks):
                    queue.async { completion(.success( apiBooks.map({ $0.model }) )) }
                case .failure(let error):
                    queue.async { completion(.failure(error.apiError)) }
                }
            })
        
        return dataRequest.task
    }
    
    @discardableResult public func offers(queue: DispatchQueue = DispatchQueue.main , completion: @escaping (Result<[Book]>) -> Void) -> URLSessionTask? {
        let dataRequest = sessionManager.request(ApiRouter.books(baseURL))
            .validate()
            .validate(contentType: ["application/json"])
            .responseArray(completionHandler: { (response:DataResponse<[HPApiBook]>) in
                
                switch response.result {
                case .success(let apiBooks):
                    queue.async { completion(.success( apiBooks.map({ $0.model }) )) }
                case .failure(let error):
                    queue.async { completion(.failure(error.apiError)) }
                }
            })
        
        return dataRequest.task
    }
}
