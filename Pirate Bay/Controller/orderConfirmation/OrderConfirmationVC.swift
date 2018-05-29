//
//  OrderConfirmationVC.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 29/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class OrderConfirmationVC: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var orderConfirmationNumberLabel: UILabel!
    
    
    // MARK: - Properties
    
    var shoppingCart = ShoppingCart.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        orderConfirmationNumberLabel.text = UUID().uuidString
    }

    
    // MARK: - IBActions
    
    @IBAction func didTapContinueShopping(_ sender: MyButton) {
        
        dismiss(animated: true, completion: nil)
        shoppingCart.reset()
    }
}
