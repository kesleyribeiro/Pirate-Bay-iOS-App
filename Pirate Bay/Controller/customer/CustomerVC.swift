//
//  CustomerVC.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 17/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class CustomerVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let navBack = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        self.navigationItem.leftBarButtonItem = navBack
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "segueAddAddress":
                
                guard let name = nameTxtField.text, let email = emailTxtField.text, let password = passwordTxtField.text, name.characters.count > 0, email.characters.count > 0, !password.isEmpty else {
                    
                    let alertController = UIAlertController(title: "Missing Information", message: "Please provide all information for name, email and password.", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    
                    alertController.addAction(okAction)
                    
                    present(alertController, animated: true, completion: nil)
                    
                    return
                }

                let customer = CustomerService.addCustomer(name: name, email: email, password: password)
                
                let addressController = segue.destination as! AddressVC
                
                addressController.customer = customer
                
            default:
                break
            }
        }
    }
        
    
}
