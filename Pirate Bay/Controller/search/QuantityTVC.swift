//
//  QuantityTVC.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 14/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

protocol QuantityPopoverDelegate: class {
    func updateProductToBuy(withQuantity quantity: Int)
}

class QuantityTVC: UITableViewController {

    // MARK: - Properties
    
    var quantities = [1,2,3,4,5,6,7,8,9]
    weak var delegate: QuantityPopoverDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return quantities.count
            
        case 1:
            return 1
            
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellQuantity", for: indexPath)
            cell.textLabel?.text = "\(quantities[indexPath.row])"
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellTenPlus", for: indexPath)
            cell.textLabel?.text = "10+"
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let selectedQty = quantities[indexPath.row]
            delegate.updateProductToBuy(withQuantity: selectedQty)
            
            dismiss(animated: true, completion: nil)
            
        case 1:
            let cell = tableView.cellForRow(at: indexPath)! as UITableViewCell
            cell.textLabel?.isHidden = true
            
            let qtyTxtField = UITextField(frame: CGRect(x: (cell.contentView.frame.width - 60/2), y: (cell.contentView.frame.height - 30/2), width: 60.0, height: 30.0))
            
            qtyTxtField.delegate = self
            qtyTxtField.font = UIFont.systemFont(ofSize: 17.0)
            qtyTxtField.keyboardType = .numberPad
            qtyTxtField.borderStyle = .roundedRect

            cell.contentView.addSubview(qtyTxtField)
            cell.contentView.backgroundColor = UIColor.white
            
        default:
            break
        }
    }
  
}


// MARK: - UITextFieldDelegate


extension QuantityTVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let qty = textField.text {
            delegate.updateProductToBuy(withQuantity: Int(qty)!)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        dismiss(animated: true, completion: nil)

        return true
    }
}
