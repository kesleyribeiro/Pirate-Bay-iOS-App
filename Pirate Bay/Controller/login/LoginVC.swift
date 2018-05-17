//
//  LoginVC.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 17/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    
    // MARK: - Properties
    
    var customer: Customer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "segueShipAddress":
                let addressController = segue.destination as! AddressVC
                addressController.customer = customer
                
            default:
                break
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func didTapCancel(_ sender: Any) {
   
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapSignIn(_ sender: MyButton) {
    
        guard let email = emailTxtField.text, let password = passwordTxtField.text else {
            return
        }
        
        customer = CustomerService.verify(username: email, password: password)
        
        if customer != nil {
            performSegue(withIdentifier: "segueShipAddress", sender: self)
        }
        else {
            let alertController = UIAlertController(title: "Login Failed", message: "We do not recognize your email and/or password. \nPlease try again!", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in
                DispatchQueue.main.sync { [weak self] in
                    self?.emailTxtField.text = ""
                    self?.passwordTxtField.text = ""
                }
            })

            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindFromCreateAccount(segue: UIStoryboardSegue) {
        
        print("Back from create acount scene.")
    }
    
    
}
