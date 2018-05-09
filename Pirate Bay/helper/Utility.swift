//
//  Utility.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 9/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class Utility {
    
    
    class func image(withName name: String?, andType type: String) -> UIImage? {
        let imagePath = Bundle.main.path(forResource: name?.stringFileExtension(), ofType: type)
        
        var image: UIImage?
        if let path = imagePath {
            image = UIImage(contentsOfFile: path)
        }
        
        return image
    }
}
