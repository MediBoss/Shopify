//
//  CustomCollectionsTableCellTableViewCell.swift
//  Shopify
//
//  Created by Medi Assumani on 3/28/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit

class CustomCollectionsTableCellTableViewCell: UITableViewCell {

    static let cellID = "custom_collections"
    @IBOutlet weak var collectionNameLabel: UILabel!
    
    func configureCellElement(colletion: Collection){
    
        collectionNameLabel.text = colletion.title
        collectionNameLabel.font = UIFont(name: "PingFangTC-Medium", size: 18)
        collectionNameLabel.textAlignment = .center
        collectionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            collectionNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
