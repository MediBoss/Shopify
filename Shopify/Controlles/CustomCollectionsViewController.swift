//
//  CustomCollectionsViewController.swift
//  Shopify
//
//  Created by Medi Assumani on 3/27/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit

class CustomCollectionsViewController: UIViewController {
    
    // - MARK: Class Properties & UI Elements
    @IBOutlet weak var customCollectionTableView: UITableView!
    var dummyData = ["One", "Two"]
    
    var customCollections = [Collection](){
        
        didSet{
            DispatchQueue.main.async {
                self.customCollectionTableView.reloadData()
            }
        }
    }
    
     // - MARK: View Controller Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBarItems()
        fetchCustomCollections()
    }
    
     // - MARK: Class Methods
    
    /// Calls the Networking method to fetch all the collections
    private func fetchCustomCollections(){
        CollectionServices.shared.fectchAllCollections { (result) in
            switch result{
                
            case let .success(fetchedCollections):
                self.customCollections = fetchedCollections
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    /// Sets up home page title and nav bar items
    private func setUpNavigationBarItems(){
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        titleLabel.text = "Custom Collections"
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        titleLabel.textAlignment = .left
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        navigationController?.navigationBar.alpha = 0.0
    }
}
