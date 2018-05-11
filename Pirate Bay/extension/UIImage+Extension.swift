//
//  UIImage+Extension.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 11/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resizeImage(newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
