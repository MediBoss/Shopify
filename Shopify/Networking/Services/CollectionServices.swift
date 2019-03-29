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
     
     - Returns: A completion handler that contains the list of spaces
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
    
    
    func fetchAllCollects(collectionID: Int,_ completion: @escaping([Collect]) -> ()) {
        
//        do {
//            let params: [String: Any] = ["page": "1",
//                                         "access_token": "c32313df0d0ef512ca64d5b336a0d7c6",
//                                         "collection_id":"\(collectionID)"
//                                        ]
//
//            let request = try HTTPNetworkRequest.configureHTTPRequest(from: .allCollections, with: params)
//
//            collectionSession.dataTask(with: request) { (data, res, err) in
//
//                if let response = res as? HTTPURLResponse, let unwrappedData = data {
//
//                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
//                    switch result {
//                    case .success:
//
//                        let result = try? JSONDecoder().decode(Collects.self, from: unwrappedData)
//                        guard let collects = result?.collects else { return }
//                        DispatchQueue.main.async {
//                            completion(Result.success(collects))
//                        }
//                    case .failure:
//                        DispatchQueue.main.async {
//                            completion(Result.failure(HTTPNetworkError.decodingFailed))
//                        }
//                    }
//                }
//            }.resume()
//
//        } catch {
//            completion(Result.failure(HTTPNetworkError.badRequest))
//        }
        
        
        let base_url = "https://shopicruit.myshopify.com/admin/collects.json"

        let parameters = [

            "collection_id":"\(collectionID)",
            "page": "1",
            "access_token": "c32313df0d0ef512ca64d5b336a0d7c6"
        ]

        // Set up parameters
        var components = URLComponents(string: "https://shopicruit.myshopify.com/admin/collects.json")
        components?.queryItems = parameters.map({ (key,value ) in
            URLQueryItem(name: key, value: value)
        })

        // Set up request
        var request = URLRequest(url: (components?.url)!)
        //request.setValue("c32313df0d0ef512ca64d5b336a0d7c6", forHTTPHeaderField: "access_token")

        collectionSession.dataTask(with: request) { (data, response, error) in

            if (error == nil) {
                guard let unwrappedData = data, let unwrappedResponse = response as? HTTPURLResponse else { return }
                switch unwrappedResponse.statusCode{
                case 200:

                    do{
                        let result = try? JSONDecoder().decode(Collects.self, from: unwrappedData)
                        guard let collects = result?.collects else { return }
                        completion(collects)
                    }

                default:
                    print("failure boi")
                }
            }
        }.resume()
    }
    
    
    func fetchAllProduct(ids: [String], _ completion: @escaping([Product]) -> ()) {
        
        var compactedIds = ""
        ids.forEach({ compactedIds += "\($0)," })
        compactedIds.removeLast()
        let url = URL(string: "https://shopicruit.myshopify.com/admin/products.json?ids=\(compactedIds)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
        
//        let parameters: [String: Any] = [
//
//            "ids": ids,
//            "page": "1",
//            "access_token": "c32313df0d0ef512ca64d5b336a0d7c6"
//        ]
        
        // Set up parameters
//        var components = URLComponents(string: "https://shopicruit.myshopify.com/admin/products.json")
//        components?.queryItems = parameters.map({ (key,value ) in
//            URLQueryItem(name: key, value: value)
//        })
        
        // Set up request
        var request = URLRequest(url: url!)
        //request.setValue("c32313df0d0ef512ca64d5b336a0d7c6", forHTTPHeaderField: "access_token")
        
        collectionSession.dataTask(with: request) { (data, response, error) in
            
            if (error == nil) {
                guard let unwrappedData = data, let unwrappedResponse = response as? HTTPURLResponse else { return }
                switch unwrappedResponse.statusCode{
                case 200:
                    
                    do{
                        let result = try? JSONDecoder().decode(Products.self, from: unwrappedData)
                        guard let products = result?.products else { return }
                        completion(products)
                    }
                    
                default:
                    print("failure boi")
                }
            }
        }.resume()
    }
}
