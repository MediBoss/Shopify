//
//  Collect.swift
//  Shopify
//
//  Created by Medi Assumani on 3/27/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation


struct Collect: Decodable {
    
    let id: Int?
    let product_id: Int?
}

struct Collects: Decodable {
    
    let collects: [Collect]?
}
