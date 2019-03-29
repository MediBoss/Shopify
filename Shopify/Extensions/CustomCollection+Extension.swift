//
//  CustomCollection+Extension.swift
//  Shopify
//
//  Created by Medi Assumani on 3/28/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation
import UIKit


extension CustomCollectionsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return customCollections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = customCollectionTableView.dequeueReusableCell(withIdentifier: CustomCollectionsTableCellTableViewCell.cellID, for: indexPath) as! CustomCollectionsTableCellTableViewCell
        
        let selectedCollection = customCollections[indexPath.row]
        cell.configureCellElement(colletion: selectedCollection)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80.0
    }
    
    /// Show all product details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destinationVC = CollectionDetailsViewController()
        let selectedCollection = customCollections[indexPath.row]
        
        CollectionServices.shared.fetchAllCollects(collectionID: selectedCollection.id!) { (result) in

//            switch result{
//
//            case let .success(fetchedCollects):
//
////                destinationVC.collection = selectedCollection
////                destinationVC.collects = fetchedCollects
////                DispatchQueue.main.async {
////                    self.navigationController?.pushViewController(destinationVC, animated: true)
////                }
//
//            case let .failure(error):
//                print(error)
//            }
        }
        
        CollectionServices.shared.fetchAllCollects(collectionID: selectedCollection.id!) { (fetchedCollects) in
            destinationVC.collection = selectedCollection
            destinationVC.collects = fetchedCollects
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(destinationVC, animated: true)
            }
        }
    }
    
}
