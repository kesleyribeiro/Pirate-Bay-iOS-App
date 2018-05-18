//
//  ExistingCreditCardTVCell.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 18/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class ExistingCreditCardTVCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var cardTypeImageView: UIImageView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var nameOnCardLabel: UILabel!
    @IBOutlet weak var expirationLabel: UILabel!
    @IBOutlet weak var noCreditCardLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    internal func configureCell(withCreditCard creditCard: CreditCard) {
        
        noCreditCardLabel.isHidden = true
        
        cardNumberLabel.text = creditCard.cardNumber?.maskedPlusLast4()
        
        cardTypeImageView.image = UIImage(named: creditCard.type!)
        
        nameOnCardLabel.text = creditCard.nameOnCard
        
        expirationLabel.text = "\(creditCard.expMonth)\(creditCard.expYear)"
    }

}
