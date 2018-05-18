//
//  NewCreditCardTVCell.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 18/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

enum CreditCardType: String {
    case Visa = "visa"
    case MasterCard = "mastercard"
    case Amex = "amex"
    case Discover = "discover"
    case Unknown = "unknown"
}

protocol creditCardDelegate: class {
    func add(card: CreditCard)
}

class NewCreditCardTVCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var nameOnCardTxtField: UITextField!
    @IBOutlet weak var cardNumberTxtField: UITextField!
    @IBOutlet weak var expMonthButton: MyButton!
    @IBOutlet weak var expYearButton: MyButton!
    
    
    // MARK: - Properties
    
    var customer: Customer?
    weak var creditCardDelegate: creditCardDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }
    
    
    // MARK: - IBActions
    
    @IBAction func didTapAddCard(_ sender: MyButton) {
   
        guard let nameOnCard = nameOnCardTxtField.text else {
            return
        }
        
        guard let cardNumber = cardNumberTxtField.text else {
            return
        }
        
        guard let expMonth = expMonthButton.titleLabel?.text else {
            return
        }
        
        guard let expYear = expYearButton.titleLabel?.text else {
            return
        }
        
        let creditCard = CustomerService.addCreditCard(forCustomer: self.customer!, nameOnCard: nameOnCard, cardNumber: cardNumber, expMonth: Int(expMonth)!, expYear: Int(expYear)!)
        
        creditCardDelegate?.add(card: creditCard)
        
        // Reset credi card infos
        nameOnCardTxtField.text = ""
        cardNumberTxtField.text = ""
        expMonthButton.setTitle("01", for: .normal)
        expYearButton.setTitle("\(Utility.currentYear())", for: .normal)
    }
    
}
