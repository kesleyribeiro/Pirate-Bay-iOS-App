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
    @IBOutlet weak var zioTxtField: UITextField!
    @IBOutlet weak var phoneNumberTxtField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var noAddressLabel: UILabel!
    
    // MARK: - Properties
    
    var customer: Customer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
