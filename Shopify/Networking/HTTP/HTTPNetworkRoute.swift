//
//  HTTPNetworkRoutes.swift
//  Lofti
//
//  Created by Medi Assumani on 2/23/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

/**
    Defines different endpoints from the Shopify API
 
 - Endpoints:
    - allCollections: Fetch all the collections
    - allCollects: Fetch all collects from a collection
    - allProducts: Fetch all prodcuts from a collection
 **/
public enum HTTPNetworkRoute: String{
    
    case allCollections = "https://shopicruit.myshopify.com/admin/custom_collections.json"
    case allCollects = "https://shopicruit.myshopify.com/admin/collects.json"
    case allProducts = "https://shopicruit.myshopify.com/admin/products.json"
}
