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
}
