//
//  Product.swift
//  Shopify
//
//  Created by Medi Assumani on 3/27/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

/**
 Defines the blueprint of each Product object
 
 Properties:
    - id: the unique id of a product
    - title: the title of a product
    - variants : the list of variants that a product contains
 
 **/


struct Product: Decodable{
    
    let id: Int?
    let title: String?
    let variants: [Variant]?
}

struct Products: Decodable{
    
    let products: [Product]?
}
