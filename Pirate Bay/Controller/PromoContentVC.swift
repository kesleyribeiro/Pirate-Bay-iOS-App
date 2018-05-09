//
//  PromoContentVC.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 8/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class PromoContentVC: UIViewController {

    // MARK: - Outlet
    
    @IBOutlet weak var promoImageView: UIImageView!
    
    
    // MARK: - Properties
    
    var pageIndex = 0
    var imageName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let currentImage = imageName {
            promoImageView.image = UIImage(named: currentImage)
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
