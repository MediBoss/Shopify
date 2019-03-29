//
//  CollectionDetailsCellCollectionViewCell.swift
//  Shopify
//
//  Created by Medi Assumani on 3/28/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Kingfisher
import UIKit

class CollectionDetailsCellCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "collection_details"
    var productNameLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont(name: "PingFangTC-Medium", size: 16)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var collectionTitleLabel: UILabel = {
       
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Light", size: 14)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var totalInventoryLabel: UILabel = {
       
        let label = UILabel()
        label.font = UIFont(name: "PingFangTC-Medium", size: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var collectionImageView: UIImageView = {
       
        var imageView = UIImageView(image: UIImage(named: "headshot"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        cellAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Sets ups all the UI elements on the cell and downloads collection's images
    func configureCellElements(product: Product, collection: Collection, totalInventory: Int) {
        
        let url = URL(string: (collection.image?.src)!)

        KingfisherManager.shared.retrieveImage(with: url!, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                self.collectionImageView.image = value.image
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
        productNameLabel.text = product.title
        collectionTitleLabel.text = collection.title
        totalInventoryLabel.text = "x\(totalInventory) available"
        
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.shadowRadius = 1
    }
    
    /// Applies Auto Layout to the cell's UI components
    private func cellAutoLayout(){
        
        let labelStackView = UIStackView(arrangedSubviews: [productNameLabel, collectionTitleLabel, totalInventoryLabel])
        let mainStackView = UIStackView(arrangedSubviews: [labelStackView, collectionImageView])
        
        labelStackView.alignment = .center
        labelStackView.axis = .vertical
        labelStackView.distribution = .fillEqually
        labelStackView.translatesAutoresizingMaskIntoConstraints = false

        mainStackView.alignment = .center
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fill
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.widthAnchor.constraint(equalTo: widthAnchor),
            mainStackView.heightAnchor.constraint(equalTo: heightAnchor),
            
            collectionImageView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.3),
            collectionImageView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.5),
            labelStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.7),
            labelStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.5),
            
            productNameLabel.widthAnchor.constraint(equalTo: labelStackView.widthAnchor, multiplier: 1),
            productNameLabel.heightAnchor.constraint(equalTo: labelStackView.heightAnchor, multiplier: 0.3),

            collectionTitleLabel.widthAnchor.constraint(equalTo: labelStackView.widthAnchor, multiplier: 1),
            collectionTitleLabel.heightAnchor.constraint(equalTo: labelStackView.heightAnchor, multiplier: 0.3),
            totalInventoryLabel.widthAnchor.constraint(equalTo: labelStackView.widthAnchor, multiplier: 1),
            totalInventoryLabel.heightAnchor.constraint(equalTo: labelStackView.heightAnchor, multiplier: 0.3)
            ])
    }   
}
