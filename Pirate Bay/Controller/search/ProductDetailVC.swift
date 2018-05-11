//
//  ProductDetailVC.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 11/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var detailSummaryView: DetailSummaryView!
    
    // MARK: - Properties
    
    var product: Product? {
        didSet {
            if let currentProduct = product {
                self.showDetail(for: currentProduct)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: Private function
    
    private func showDetail(for currentProduct: Product) {
        
        if viewIfLoaded != nil {
            detailSummaryView.updateView(with: currentProduct)
        }
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
