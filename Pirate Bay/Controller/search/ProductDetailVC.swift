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
    @IBOutlet weak var shoppingCartButton: UIBarButtonItem!
    
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
    
    // Shopping Cart Button with custom view
    let cartButton = UIButton(frame: CGRect(x: 10, y: 10, width: 35, height: 30))
    let cartLabel = UILabel(frame: CGRect(x: 22, y: 2, width: 16, height: 16))
    let cartView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCartView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cartLabel.text = "\(self.shoppingCart.totalItem())"
    }

    // MARK: Private function
    
    private func setCartView() {
        
        cartButton.setBackgroundImage(UIImage(named: "shopping-cart"), for: .normal)
        cartButton.addTarget(self, action: #selector(ProductDetailVC.viewCart(sender:)), for: .touchUpInside)
        cartLabel.text = "0"
        cartLabel.textColor = UIColor(red: 0.808, green: 0.490, blue: 0.173, alpha: 1.0)
        cartLabel.textAlignment = .center
        cartLabel.font = UIFont(name: "System", size: 14.0)
        cartLabel.numberOfLines = 1
        cartLabel.adjustsFontSizeToFitWidth = true

        cartView.addSubview(cartButton)
        cartView.addSubview(cartLabel)
        
        shoppingCartButton.customView = cartView
    }
    
    @objc func viewCart(sender: UIButton) {
        
        performSegue(withIdentifier: "segueToCart", sender: self)
    }
    
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
                
            case "segueToCart":
                let navController = segue.destination as! UINavigationController
                let cartTVC = navController.topViewController as! CartTVC
                cartTVC.cartDelegate = self
                
                
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
                self?.cartButton.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi), 0.0, 1.0, 0.0)
            })
            
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                self?.cartButton.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi) * 2, 0.0, 1.0, 0.0)
                }, completion: { (sucess: Bool) in
                    DispatchQueue.main.async { [unowned self] in
                        self.cartLabel.text = "\(self.shoppingCart.totalItem())"
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


// MARK: - ShoppingCartDelegate

extension ProductDetailVC: ShoppingCartDelegate {
    
    func updateTotalCartItem() {
        cartLabel.text = "\(shoppingCart.totalItem())"        
    }
}
