//
//  CollectionDetailsViewController.swift
//  Shopify
//
//  Created by Medi Assumani on 3/28/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit

class CollectionDetailsViewController: UIViewController {

    var collection: Collection?
    var collects: [Collect]?
    var totalVariants = 0
    var products = [Product](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    lazy var collectionView: UICollectionView = {
        
        // Instantiating the UICollectionView, using the default flow layout
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        //Registering the cell
        collectionView.register(CollectionDetailsCellCollectionViewCell.self, forCellWithReuseIdentifier: CollectionDetailsCellCollectionViewCell.cellID)
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
        setUpNavigationBarItems()
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(collectionView)
    }
    
    private func fetchProducts(){
        
        guard let productIDs: [String] = collects?.map({ $0.product_id!.toString() }) else { return }
        
        CollectionServices.shared.fetchAllProduct(ids: productIDs) { (result) in

            switch result{

            case let .success(fetchedProducts):
                self.products = fetchedProducts

            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    private func setUpNavigationBarItems(){
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        guard let name = collection?.title else { return }
        titleLabel.text = "\(name)"
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "PingFangTC-Medium", size: 20)
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.alpha = 1
    }
}
