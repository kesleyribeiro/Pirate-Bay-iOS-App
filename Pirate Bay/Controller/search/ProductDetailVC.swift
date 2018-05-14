//
//  ProductDetailVC.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 11/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var detailSummaryView: DetailSummaryView!
    @IBOutlet weak var productDescriptionImageView: UIImageView!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shoppingCartButton: UIButton!
    @IBOutlet weak var cartItemCountLabel: UILabel!
    
    // MARK: - Properties
    
    var product: Product? {
        didSet {
            if let currentProduct = product {
                self.showDetail(for: currentProduct)
            }
        }
    }
    
    var specifications = [ProductInfo]()
    var quantity = 1
    var shoppingCart = ShoppingCart.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: Private function
    
    private func showDetail(for currentProduct: Product) {
        
        if viewIfLoaded != nil {
            detailSummaryView.updateView(with: currentProduct)
            
            let productInfo = currentProduct.productInfo?.allObjects as! [ProductInfo]
            specifications = productInfo.filter({$0.type == "specs"})
            
            var description = ""
            
            for currentInfo in productInfo {
                
                if let info = currentInfo.info, info.characters.count > 0, currentInfo.type == "description" {
                    description = description + info + "\n\n"
                }
            }
            productDescriptionLabel.text = description
            productDescriptionImageView.image = Utility.image(withName: currentProduct.mainImage, andType: "jpg")
            
            tableView.reloadData()
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "segueQuantity":
                let quantityTVC = segue.destination as! QuantityTVC
                quantityTVC.delegate = self
                
            default:
                break
            }
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func didTapAddToCart(_ sender: MyButton) {

        if let product = product {
            shoppingCart.add(product: product, qty: self.quantity)
            
            // Reset the quantity
            self.quantity = 1
            self.detailSummaryView.quantityButton.setTitle("Quantity: 1", for: .normal)
            
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                self?.shoppingCartButton.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi), 0.0, 1.0, 0.0)
            })
            
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                self?.shoppingCartButton.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi) * 2, 0.0, 1.0, 0.0)
                }, completion: { (sucess: Bool) in
                    DispatchQueue.main.async { [unowned self] in
                        self.cartItemCountLabel.text = "\(self.shoppingCart.totalItem())"
                    }
                }
            )
        }
    }
    
}


// MARK: - UITableViewDataSource

extension ProductDetailVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProductInfo", for: indexPath) as! ProductInfoTVCell
        
        cell.productInfo = specifications[indexPath.row]
        
        return cell
    }
}


// MARK: - QuantityPopoverDelegate

extension ProductDetailVC: QuantityPopoverDelegate {
    
    func updateProductToBuy(withQuantity quantity: Int) {
        self.quantity = quantity
        detailSummaryView.quantityButton.setTitle("Quantity: \(self.quantity)", for: .normal)
    }
}
