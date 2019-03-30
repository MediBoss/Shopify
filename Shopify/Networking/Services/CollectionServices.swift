//
//  CollectionServices.swift
//  Shopify
//
//  Created by Medi Assumani on 3/27/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

struct CollectionServices {
    
    static let shared = CollectionServices()
    let collectionSession = URLSession(configuration: .default)
    
    /**
        Fetches all available collection from shopify API
     
     - Parameters:
        - completion: The funtion returns a success/failure result with a list of collections
     
     - Throws:
        - `HTTPNetworkError.decodingFailed`: If the model fails to decode
        - `HTTPNetworkError.badRequest`: If the request object is built incorrecttly
     
     - Returns: A completion handler that contains the list of collections
     **/
    func fectchAllCollections(_ completion: @escaping(Result<[Collection]>) -> ()){
        
        do {
            let params: [String: Any] = ["page": "1", "access_token": "c32313df0d0ef512ca64d5b336a0d7c6"]
            let request = try HTTPNetworkRequest.configureHTTPRequest(from: .allCollections, with: params)
            
            collectionSession.dataTask(with: request) { (data, res, err) in
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        
                        let result = try? JSONDecoder().decode(Collections.self, from: unwrappedData)
                        guard let collections = result?.custom_collections else { return }
                        DispatchQueue.main.async {
                            completion(Result.success(collections))
                        }
                    case .failure:
                        DispatchQueue.main.async {
                            completion(Result.failure(HTTPNetworkError.decodingFailed))
                        }
                    }
                }
            }.resume()
            
        } catch {
            completion(Result.failure(HTTPNetworkError.badRequest))
        }
    }
    
    /**
     Fetches all available collects from shopify API
     
     - Parameters:
        - completion: The funtion returns a success/failure result with a list of collects
        - collectionID : The unique ID of a single collection
     
     - Throws:
     - `HTTPNetworkError.decodingFailed`: If the model fails to decode
     - `HTTPNetworkError.badRequest`: If the request object is built incorrecttly
     
     - Returns: A completion handler that contains the list of collects
     **/
    func fetchAllCollects(collectionID: Int,_ completion: @escaping(Result<[Collect]>) -> ()) {

        let parameters = [
            "collection_id":"\(collectionID)",
            "page": "1",
            "access_token": "c32313df0d0ef512ca64d5b336a0d7c6"]

        var components = URLComponents(string: HTTPNetworkRoute.allCollects.rawValue)
        components?.queryItems = parameters.map({ (key,value ) in
            URLQueryItem(name: key, value: value)
        })

        var request = URLRequest(url: (components?.url)!)
        collectionSession.dataTask(with: request) { (data, response, error) in

            if (error == nil) {
                guard let unwrappedData = data, let unwrappedResponse = response as? HTTPURLResponse else { return }
                let result = HTTPNetworkResponse.handleNetworkResponse(for: unwrappedResponse)
                switch result{
                    
                case .success:
                    let result = try? JSONDecoder().decode(Collects.self, from: unwrappedData)
                    guard let collects = result?.collects else { return }
                    DispatchQueue.main.async {
                        completion(Result.success(collects))
                    }
                case .failure:
                    DispatchQueue.main.async {
                        completion(Result.failure(HTTPNetworkError.decodingFailed))
                    }
                }
            }
        }.resume()
    }
    
    /**
     Fetches all available products from shopify API
     
     - Parameters:
        - completion: The funtion returns a success/failure result with a list of products
        - ids : A list of all the products' id from a single collect
     
     - Throws:
        - `HTTPNetworkError.decodingFailed`: If the model fails to decode
        - `HTTPNetworkError.badRequest`: If the request object is built incorrecttly
     
     - Returns: A completion handler that contains the list of products
     **/
    func fetchAllProduct(ids: [String], _ completion: @escaping(Result<[Product]>) -> ()) {
        
        var compactedIds = ""
        ids.forEach({ compactedIds += "\($0)," })
        compactedIds.removeLast()
        let url = URL(string: "https://shopicruit.myshopify.com/admin/products.json?ids=\(compactedIds)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
        
        let request = URLRequest(url: url!)
        
        collectionSession.dataTask(with: request) { (data, response, error) in
            if (error == nil) {
                guard let unwrappedData = data, let unwrappedResponse = response as? HTTPURLResponse else { return }
                let result = HTTPNetworkResponse.handleNetworkResponse(for: unwrappedResponse)
                switch result{
                    
                case .success:
                    let result = try? JSONDecoder().decode(Products.self, from: unwrappedData)
                    guard let collects = result?.products else { return }
                    DispatchQueue.main.async {
                        completion(Result.success(collects))
                    }
                case .failure:
                    DispatchQueue.main.async {
                        completion(Result.failure(HTTPNetworkError.decodingFailed))
                    }
                }
            } 
        }.resume()
    }
}
