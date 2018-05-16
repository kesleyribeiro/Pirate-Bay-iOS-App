//
//  ItemInCartTVCell.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 16/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class ItemInCartTVCell: UITableViewCell {

    // MARK: - IBOulets
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var qtyTxtField: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Properties
    
    var shoppingCart = ShoppingCart.sharedInstance
    var item: (product: Product, qty: Int)? {
        didSet {
            if let currentItem = item {
                refreshCell(currentItem: currentItem)
            }
        }
    }
    
    var itemIndexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        qtyTxtField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Private functions
    
    private func refreshCell(currentItem: (product: Product, qty: Int)) {
        
        productImageView.image = Utility.image(withName: currentItem.product.mainImage, andType: "jpg")
        productNameLabel.text = currentItem.product.name
        qtyTxtField.text = "\(currentItem.qty)"
        priceLabel.text = currentItem.product.salePrice.currencyFormatter
    }
    
    
    // MARK: - IBActions
    
    @IBAction func didTapToRemove(_ sender: Any) {
        
    }
}


// MARK: - UITextFieldDelegate

extension ItemInCartTVCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let qty = qtyTxtField.text, let currentItem = self.item {
            shoppingCart.update(product: currentItem.product, qty: Int(qty)!)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}


