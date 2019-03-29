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
    
    /**
     Sets up the request to be made to the shopify API
     
     - Parameters:
        - route : the endpoint where the data will be requested from
        - parameters: the parameters to be sent along on the request
     
     - Returns: a fully configured URLRequest object
     **/
    static func configureHTTPRequest(from route: HTTPNetworkRoute, with parameters: HTTPParameters) throws -> URLRequest {
        
        guard let url = URL(string: route.rawValue) else { fatalError("Error while unwrapping url")}
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        
        try configureParameters(parameters: parameters, request: &request)
        
        return request
    }
    
    
    /**
     Sets up the parameters from the client before making the request
     
     - Parameters:
        - parameters : the parameters to be sent along on the request
        - request: the request object to configure the parameter with
     
     - Throws:
        - `HTTPNetworkError.encodingFailed`: If the parameter could not be encoded
     **/
    static func configureParameters(parameters: HTTPParameters?, request: inout URLRequest) throws {

        do {
            if let unwrappedParameters = parameters {
                try encodeParameters(for: &request, with: unwrappedParameters)
            }
        } catch {
            throw HTTPNetworkError.encodingFailed
        }
    }
    
    
    /**
     Encodes the client parameters and appends it the request object
     
     - Parameters:
        - urlRequest : the same URLRequest object to be used wit URLDataTask Class
        - parameters: the request object to configure the parameter with
     
     - Throws:
        - `HTTPNetworkError.missingURL`: If URLRequest object failed to provide an URL
     **/
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
