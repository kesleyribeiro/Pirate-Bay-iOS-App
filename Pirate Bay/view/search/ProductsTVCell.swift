//
//  ProductsTVCell.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 9/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class ProductsTVCell: UITableViewCell {

    // MARK: - Outlet
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var userRating: UserRating!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func configureCell(with product: Product) {
        
        productImageView.image = Utility.image(withName: product.mainImage, andType: "jpg")
        productNameLabel.text = product.name
        manufacturerLabel.text = product.manufacturer?.name
        priceLabel.text = product.salePrice.currencyFormatter
        userRating.rating = Int(product.rating)
    }

}
