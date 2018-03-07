//
//  ApiRouter.swift
//  HenriPotierApiClient
//
//  Created by Mohamed Aymen Landolsi on 07/03/2018.
//  Copyright © 2018 Rokridi. All rights reserved.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    case books(String)
    
    private var baseURL: String {
        switch self {
        case .books(let baseURL):
            return baseURL
        }
    }
    
    var path: String {
        switch self {
        case .books(_):
            return "books"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .books(_):
            return .get
        }
    }
    
    var parameters: [String: AnyObject] {
        return [:]
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try self.baseURL.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
