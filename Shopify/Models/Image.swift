//
//  Image.swift
//  Shopify
//
//  Created by Medi Assumani on 3/28/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

/**
 Defines the blueprint of each collection object
 
 Properties:
    - src: the URL that links to the image storage location
    - width: the width of the image
    - height : the height of the image
 
 **/
struct Image: Decodable {
    
    let src: String?
    let width: Int?
    let height: Int?
}
