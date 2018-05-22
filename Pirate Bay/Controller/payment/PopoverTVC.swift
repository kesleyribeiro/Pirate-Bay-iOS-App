//
//  PopoverTVC.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 22/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

enum PopInfoType: String {
    case ExpMonth = "Expiration Month"
    case ExpYear = "Expiration Year"
}

protocol PopInfoSelectionDelegate: class {
    func updateWithPopInfoSelection(value: String, sender: UIButton)
}

class PopoverTVC: UITableViewController {
    
    // MARK: - Properties
    
    var popInfoType: PopInfoType?
    var data = [String]()
    var sender: UIButton?
    weak var delegate: PopInfoSelectionDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch popInfoType! {
        case .ExpMonth:
            data = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
            
        case .ExpYear:
            let currentYear = Utility.currentYear()
            
            for year in currentYear...currentYear+10 {
                data.append(String(year))
            }
        }
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.rowHeight = 40
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellExpiration", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        delegate?.updateWithPopInfoSelection(value: data[indexPath.row], sender: self.sender!)
        
        dismiss(animated: true, completion: nil)
    }
    
}
