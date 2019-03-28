//
//  Product.swift
//  Shopify
//
//  Created by Medi Assumani on 3/27/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

struct Product: Decodable{
    
    let id: Int?
    let title: String?
    let vendor: String?
    let variants: [Variant]?
}

struct Products: Decodable{
    
    let products: [Product]?
}
