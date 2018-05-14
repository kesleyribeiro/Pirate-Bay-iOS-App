//
//  ProductsTVC.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 9/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class ProductsTVC: UITableViewController {

    // MARK: - Properties
    
    var products: [Product]?
    var selectedProduct: Product?
    weak var delegate: ProductDetailVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.products = ProductService.search()
        
        if let products = self.products {
            selectedProduct = products.first
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let products = self.products {
            return products.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.rowHeight = 70
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProduct", for: indexPath) as! ProductsTVCell

        if let currentProduct = self.products?[indexPath.row] {
            if selectedProduct?.id == currentProduct.id {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                
                cell.contentView.layer.borderWidth = 1
                cell.contentView.layer.borderColor = UIColor().pirateBay_brown().cgColor
                
                delegate?.product = selectedProduct
            }
            else {
                cell.contentView.layer.borderWidth = 0
                cell.contentView.layer.borderColor = UIColor.clear.cgColor
            }
            
            cell.configureCell(with: currentProduct)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = products?[indexPath.row]
        delegate?.product = selectedProduct
        
        tableView.reloadData()
    }

}
