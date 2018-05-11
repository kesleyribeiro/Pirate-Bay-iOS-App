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
        
        print(product.name)
    }
    
}
