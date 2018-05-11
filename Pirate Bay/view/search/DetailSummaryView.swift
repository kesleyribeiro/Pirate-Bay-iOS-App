//
//  DetailSummaryView.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 11/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class DetailSummaryView: UIView {

    // MARK: - IBOutlet
    
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var listPriceLabel: UILabel!
    @IBOutlet weak var dealPriceLabel: UILabel!
    @IBOutlet weak var priceSavedDollarLabel: UILabel!
    @IBOutlet weak var priceSavedPercentLabel: UILabel!
    @IBOutlet weak var inStockLabel: UILabel!
    @IBOutlet weak var qtyLeftLabel: UILabel!
    @IBOutlet weak var quantityButton: UIButton!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var productImagesView: UIImageView!
    @IBOutlet weak var userRating: UserRating!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal func updateView(with product: Product) {
        
        // Set default state
        qtyLeftLabel.isHidden = true
        quantityButton.setTitle("Quantity: 1", for: .normal)
        quantityButton.isEnabled = true
        quantityButton.alpha = 1.0
        addToCartButton.isEnabled = true
        addToCartButton.alpha = 1.0
        
        // Product Info
        manufacturerLabel.text = product.manufacturer?.name
        productNameLabel.text = product.name
        userRating.rating = Int(product.rating)
        
        
        let listPriceAttributedString = NSAttributedString(string: product.regularPrice.currencyFormatter, attributes: [NSAttributedStringKey.strikethroughStyle: 1])
        listPriceLabel.attributedText = listPriceAttributedString
        
        dealPriceLabel.text = product.salePrice.currencyFormatter
        priceSavedDollarLabel.text = (product.regularPrice - product.salePrice).currencyFormatter
        
        let percentSafe = ((product.regularPrice - product.salePrice) / product.regularPrice).percentFormatter
        priceSavedPercentLabel.text = percentSafe
        
        if product.quantity > 0 {
            inStockLabel.textColor = UIColor().pirateBay_green()
            inStockLabel.text = "In Stock"
            
            if product.quantity < 5 {
                qtyLeftLabel.isHidden = false
                let qtyLeftString = product.quantity == 1 ? "item" : "items"
                qtyLeftLabel.text = "Only \(product.quantity) \(qtyLeftString) left"
            }
        }
        else {
            inStockLabel.textColor = UIColor.red
            inStockLabel.text = "Currently Unavailable"
            
            quantityButton.setTitle("Quantity: 0", for: .normal)
            quantityButton.isEnabled = false
            quantityButton.alpha = 0.0
            
            addToCartButton.isEnabled = false
            addToCartButton.alpha = 0.5
        }
        
        if let images = product.productImages {
            let allImages = images.allObjects as! [ProductImage]
            
            if let mainImage = allImages.first {
                productImagesView.image = Utility.image(withName: mainImage.name, andType: "jpg")
            }
        }
        
    }
    
}
