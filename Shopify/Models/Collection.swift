//
//  Collection.swift
//  Shopify
//
//  Created by Medi Assumani on 3/27/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit

/**
 Defines the blueprint of each collection object
 
 Properties:
    - id: the unique id of a collection
    - title: the title of the collection
    - image : the image of the collection
 
 **/
struct Collection: Decodable{
    
    let id: Int?
    let title: String?
    let image: Image?
}

struct Collections: Decodable{
    
    let custom_collections: [Collection]?
}
