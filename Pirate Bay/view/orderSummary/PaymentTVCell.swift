//
//  PaymentTVCell.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 22/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class PaymentTVCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var nameOnCardLabel: UILabel!
    @IBOutlet weak var expirationLabel: UILabel!
    
    // MARK: - Properties
    
    let shoppingCart = ShoppingCart.sharedInstance

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func configureCell() {
        
        if let creditCard = shoppingCart.creditCard {
            let cardType = creditCard.type
            
            cardImageView.image = UIImage(named: cardType!)
            cardNumberLabel.text = creditCard.cardNumber?.maskedPlusLast4()
            nameOnCardLabel.text = creditCard.nameOnCard
            expirationLabel.text = "\(creditCard.expMonth)/\(creditCard.expYear)"
            
        }
    }

}
