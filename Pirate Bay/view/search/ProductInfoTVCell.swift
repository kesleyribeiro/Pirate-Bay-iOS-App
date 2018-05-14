//
//  ProductInfoTVCell.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 14/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class ProductInfoTVCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var productSpecLabel: UILabel!
    
    // MARK: - Properties
    
    var productInfo: ProductInfo? {
        didSet {
            if let currentInfo = productInfo {
                configureCell(with: currentInfo)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    private func configureCell(with productInfo: ProductInfo) {
        infoTitleLabel.text = productInfo.title
        productSpecLabel.text = productInfo.info
    }

}
