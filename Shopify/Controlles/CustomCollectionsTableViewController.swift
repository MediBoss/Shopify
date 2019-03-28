//
//  CustomCollectionsTableViewController.swift
//  Shopify
//
//  Created by Medi Assumani on 3/27/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit

class CustomCollectionsTableViewController: UIViewController {
    @IBOutlet weak var customCollectionsTableView: UITableView!
    
    var customCollections = [Collection](){
        
        didSet{
            DispatchQueue.main.async {
                self.customCollectionsTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

//        let ids = ["2759137027,", "2759143811"]
//        CollectionServices.shared.fetchAllProduct(ids: ids) { (product) in
//            print(product)
        
        fetchCustomCollections()
        }
    
    private func fetchCustomCollections(){
        CollectionServices.shared.fectchAllCollections { (collections) in
            self.customCollections = collections
        }
    }
}



extension CustomCollectionsTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return customCollections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = customCollectionsTableView.dequeueReusableCell(withIdentifier: CustomCollectionsTableCellTableViewCell.cellID, for: indexPath) as! CustomCollectionsTableCellTableViewCell
        
        let selectedCollection = customCollections[indexPath.row]
        
        cell.collectionNameLabel.text = selectedCollection.title
        
        return cell
    }
    
    /// Show all product details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCollection = customCollections[indexPath.row]
        CollectionServices.shared.fetchAllCollects(collectionID: selectedCollection.id ?? 0) { (collects) in
            
        }
    }
    
}
