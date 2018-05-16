//
//  CartTVC.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 16/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class CartTVC: UITableViewController {
    
    // MARK: - IBOutles
    
    @IBOutlet weak var checkoutButton: UIBarButtonItem!
    
    // MARK: - Properties
    
    var shoppingCart = ShoppingCart.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkoutButton.isEnabled = shoppingCart.totalItem() > 0 ? true : false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return shoppingCart.items.count
            
        case 1:
            return 1

        default:
            return 0
        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Review Items"
            
        default:
            return ""
        }
    }

    // MARK: - IBActions
    
    @IBAction func didTapShopping(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
