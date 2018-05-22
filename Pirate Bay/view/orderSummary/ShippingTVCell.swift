//
//  ShippingTVCell.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 22/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class ShippingTVCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var address1Label: UILabel!
    @IBOutlet weak var address2Label: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    
    // MARK: - Properties
    
    let shoppingCart = ShoppingCart.sharedInstance
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func configureCell() {
        
        if let customer = shoppingCart.customer, let shippingAddress = shoppingCart.shippingAddress {
            
            customerNameLabel.text = customer.name
            phoneLabel.text = customer.phone
            address1Label.text = shippingAddress.address1
            
            if let address2 = shippingAddress.address2 {
                address2Label.text = address2
            } else {
                address2Label.text = ""
            }
            
            cityLabel.text = "\(shippingAddress.city!), "
            stateLabel.text = shippingAddress.state
            zipLabel.text = shippingAddress.zip
        }
    }

}
