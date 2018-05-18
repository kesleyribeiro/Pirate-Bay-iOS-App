//
//  String+Extension.swift
//  Pirate Bay
//
//  Created by Kesley Ribeiro on 9/May/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

extension String {

    func stringFileExtension() -> String {
        if self.contains(".") {
            // toy.jpg, .png
            return self.substring(to: self.characters.index(of: ".")!)
        }
        return self
    }
    
    func maskedPlusLast4() -> String {
        let last4CardNumber = self.substring(from: self.index(self.endIndex, offsetBy: -4))
        
        return "****\(last4CardNumber)"
    }
}
