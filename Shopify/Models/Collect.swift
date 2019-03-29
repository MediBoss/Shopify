//
//  Collect.swift
//  Shopify
//
//  Created by Medi Assumani on 3/27/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

/**
 Defines the blueprint of each collect object
 
 Properties:
    - id: the unique id of a collect
    - product_id: the unique id of a product
 **/

struct Collect: Decodable {
    
    let id: Int?
    let product_id: Int?
}

struct Collects: Decodable {
    
    let collects: [Collect]?
}
