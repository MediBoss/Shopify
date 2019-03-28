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
    
    
    func fectchAllCollections(_ completion: @escaping([Collection]) -> ()){
        
        let path = URL(string: "https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
        let request = URLRequest(url: path!)
        
        
        collectionSession.dataTask(with: request) { (data, response, error) in
            
            if (error == nil) {
                
                guard let unwrappedData = data, let unwrappedResponse = response as? HTTPURLResponse else { return }
                switch unwrappedResponse.statusCode{
                case 200:
                    
                    do{
                        let result = try? JSONDecoder().decode(Collections.self, from: unwrappedData)
                        guard let collections = result?.custom_collections else { return }
                        DispatchQueue.main.async {
                            completion(collections)
                        }
                    }
                    
                default:
                    print("failure boi")
                }
            }
        }.resume()
    }
    
    
    func fetchAllCollects(collectionID: Int,_ completion: @escaping([Collect]) -> ()) {
        
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
        
        let base_url = "https://shopicruit.myshopify.com/admin/collects.json"
        
        let parameters = [
            
            "ids":"\(ids)",
            "page": "1",
            "access_token": "c32313df0d0ef512ca64d5b336a0d7c6"
        ]
        
        // Set up parameters
        var components = URLComponents(string: "https://shopicruit.myshopify.com/admin/products.json")
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
                        let result = try? JSONDecoder().decode(Products.self, from: unwrappedData)
                        guard let product = result?.products else { return }
                        completion(product)
                    }
                    
                default:
                    print("failure boi")
                }
            }
            }.resume()
    }
}
