//
//  AddressVC.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 17/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class AddressVC: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var addressPickerView: UIPickerView!
    @IBOutlet weak var fullnameTxtField: UITextField!
    @IBOutlet weak var address1TxtField: UITextField!
    @IBOutlet weak var address2TxtField: UITextField!
    @IBOutlet weak var cityTxtField: UITextField!
    @IBOutlet weak var stateTxtField: UITextField!
    @IBOutlet weak var zipTxtField: UITextField!
    @IBOutlet weak var phoneNumberTxtField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var noAddressLabel: UILabel!
    

    // MARK: - Properties
    
    var customer: Customer?
    var addresses = [Address]()
    var selectedAddress: Address?
    var activeTextField: UITextField?
    var shoppingCart = ShoppingCart.sharedInstance
    
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addressPickerView.isHidden = false
        noAddressLabel.isHidden = true
        
        if let customer = customer {
            addresses = CustomerService.addressList(forCustomer: customer)
            
            if addresses.count == 0 {
                addressPickerView.isHidden = true
                noAddressLabel.isHidden = false
            }
        }
    }
    
    
    // MARK: - Privete functions
    
    private func registerForKeyboardNotification() {
        
        let notificationCenter = NotificationCenter.default

        notificationCenter.addObserver(self, selector: #selector(AddressVC.keyboardIsOn(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(AddressVC.keyboardIsOff(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardIsOn(sender: Notification) {
        
        let info: NSDictionary = sender.userInfo! as NSDictionary
        let value: NSValue = info.value(forKey: UIKeyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize = value.cgRectValue.size
        
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height - 90, 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardIsOff(sender: Notification) {
        
        scrollView.setContentOffset(CGPoint(x: 0, y: -50), animated: true)
        scrollView.isScrollEnabled = false
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            switch identifier {
            case "segueToPayment":
                if let customer = customer {
                    shoppingCart.assignCart(toCustomer: customer, items:shoppingCart.items)
                    
                    var address: Address
                    
                    if !(address1TxtField.text?.isEmpty)! {
                        
                        address = CustomerService.addAddress(forCustomer: customer, address1: address1TxtField.text!, address2: address2TxtField.text!, city: cityTxtField.text!, state: stateTxtField.text!, zip: zipTxtField.text!, phone: phoneNumberTxtField.text!)
                        
                        shoppingCart.assignShipping(address: address)
                    }
                    else {
                        if selectedAddress == nil {
                            selectedAddress = addresses[self.addressPickerView.selectedRow(inComponent: 0)]
                        }
                        
                        shoppingCart.assignShipping(address: selectedAddress!)
                    }
                    
                    let paymentController = segue.destination as! PaymentVC
                    paymentController.customer = customer
                }
                
            default:
                break
            }
        }
    }
 
}


// MARK: - UIPickerViewDataSource and Delegate


extension AddressVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return addresses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let address = addresses[row]
        
        return "\(address.address1!) \(address.address2!), \(address.city!), \(address.state!) \(address.zip!) "
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAddress = addresses[row]
    }
}


// MARK: - UITextFieldDelegate

extension AddressVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        scrollView.isScrollEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        activeTextField = nil
        
        return true
    }
}
