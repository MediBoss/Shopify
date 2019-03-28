//
//  HomePageViewController.swift
//  Shopify
//
//  Created by Medi Assumani on 3/27/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CollectionServices.shared.fetchAllCollects(collectionID: "68424466488") { (collection) in
            print(collection)
        }
    }

}
