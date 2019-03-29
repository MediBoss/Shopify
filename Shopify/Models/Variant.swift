//
//  Variant.swift
//  Shopify
//
//  Created by Medi Assumani on 3/27/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

/**
 Defines the blueprint of each variant object
 
 Properties:
    - id: the unique id of a variant
    - inventory_quantity: the amount of inventory that a variant obtains
 **/

struct Variant: Decodable{
    
    let id: Int?
    let inventory_quantity: Int?
}
