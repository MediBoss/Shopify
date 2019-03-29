//
//  HTTPNetworkRequest.swift
//  Lofti
//
//  Created by Medi Assumani on 2/16/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

public typealias HTTPParameters = [String: Any]?
public typealias HTTPHeaders = [String: Any]?

struct HTTPNetworkRequest {
    
    /// Set the body, method, headers, and paramaters of the request
    static func configureHTTPRequest(from route: HTTPNetworkRoute, with parameters: HTTPParameters) throws -> URLRequest {
        
        guard let url = URL(string: route.rawValue) else { fatalError("Error while unwrapping url")}
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        
        try configureParameters(parameters: parameters, request: &request)
        
        return request
    }
    
    /// Configure the request parameters and headers before the API Call
    static func configureParameters(parameters: HTTPParameters?, request: inout URLRequest) throws {

        do {
            if let unwrappedParameters = parameters {
                try encodeParameters(for: &request, with: unwrappedParameters)
            }
        } catch {
            throw HTTPNetworkError.encodingFailed
        }
    }
    
    static func encodeParameters(for urlRequest: inout URLRequest, with parameters: HTTPParameters) throws {
        if parameters == nil { return }
        guard let url = urlRequest.url, let unwrappedParameters = parameters else { throw HTTPNetworkError.missingURL }
        
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !unwrappedParameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in unwrappedParameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
    }
}
